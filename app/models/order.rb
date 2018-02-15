class Order < ApplicationRecord
    include OrderConcerns::Razorpay


  belongs_to :customer, optional: true

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :shippings


  validates :status, presence: true,
    inclusion: {in: %w(pending cancelled paid accepted packed pickedup shipped returned),
                message: "%{value} is not a valid status" }

    scope :by_email, lambda { |email| where("email = ?", email) if email.present? }
  scope :by_recency, -> { order('orders.created_at desc') }

  [:authorized, :captured, :refunded, :error].each do |scoped_key|
    scope scoped_key, -> { where('LOWER(status) = ?', scoped_key.to_s.downcase) }
  end

  def self.by_status(status)
    if status.present? && status != 'all'
      order.where(status: status)
    end
  end

  # def self.by(user)
  #   where(user_id: user.id)
  # end
  def self.by(customer)
    where(customer_id: customer.id)
  end

  def self.create_and_charge(params)

    razorpay_pmnt_obj = fetch_payment(params[:payment_id])
    status = fetch_payment(params[:payment_id]).status
    if status == 'authorized'

      razorpay_pmnt_obj.capture({amount: (params[:cart].total * 100).to_i})
      razorpay_pmnt_obj = fetch_payment(params[:payment_id])

      community_order = false
      self_order = false
      params[:cart].items.each do |cart_item|
        if !cart_item.product.community_product_id.present?
          if self_order != true
            self_order = true
          end
        else
          if community_order != true
            community_order = true
          end
        end
      end

      if self_order == true
        order = create(status: 'paid', customer_id: params[:customer].id, payment_id: params[:payment_id], payment_status: razorpay_pmnt_obj.status, order_reference: razorpay_pmnt_obj.order_id)

        params[:cart].items.each do |cart_item|
          #byebug
          if cart_item.product.community_product_id.present?
            order.order_items.create(product_id: cart_item.product.id,
                                     unit_price: cart_item.unit_price,
                                     selling_price: cart_item.selling_price,
                                     # percent_off: cart_item.percent_off,
                                     quantity: cart_item.quantity,
                                     size: cart_item.size,
                                     color: cart_item.color)
          end

          this_cart_item = Product.find_by(id: cart_item.product.id)
          if this_cart_item.community_product_id.present?
            if community_order != true
              community_order = true
            end
          # else
            # this_cart_item.quantity = (this_cart_item.quantity.to_i - cart_item.quantity.to_i).to_i
            # byebug
            # if this_cart_item.quantity == 0
            #   this_cart_item.status = "retired"
            #   this_cart_item.save
            #   @related_community_products = Product.where(source_product_id: this_cart_item.id)
            #   @related_community_products.each do |community_product|
            #     community_product.status = "retired"
            #     community_product.save
            #   end
            # end
          end
        end
      end

      if community_order == true
        # order @ origin store
        params[:cart].items.each do |cart_item|
          if cart_item.product.community_product_id.present?

            shop_other_order = create(status: 'paid', customer_id: params[:customer].id, payment_id: params[:payment_id], payment_status: razorpay_pmnt_obj.status, order_reference: razorpay_pmnt_obj.order_id)



            shop_other_order.order_items.create(product_id: cart_item.product.id,
                                                unit_price: cart_item.unit_price,
                                                selling_price: cart_item.selling_price,
                                                # percent_off: cart_item.percent_off,
                                                quantity: cart_item.quantity,
                                                size: cart_item.size,
                                                color: cart_item.color)

            # creating order at source
            # byebug
            # if params[:page][:tenant].present?
              Apartment::Tenant.switch(CommunityProduct.find(cart_item.product.community_product_id).source) do


                this_cart_item = Product.find_by(id: CommunityProduct.find(cart_item.product.community_product_id).source_product_id)

                other_order = create(status: 'paid', payment_id: params[:payment_id], payment_status: razorpay_pmnt_obj.status, order_reference: razorpay_pmnt_obj.order_id)

                other_order.order_items.create(product_id: this_cart_item.id,
                                               unit_price: this_cart_item.reseller_price,
                                               selling_price: this_cart_item.reseller_price,
                                               # percent_off: this_cart_item.percent_off,
                                               quantity: cart_item.quantity,
                                               size: cart_item.size,
                                               color: cart_item.color)

              end
            # end

            # this_cart_item.quantity = (this_cart_item.quantity.to_i - cart_item.quantity.to_i).to_i

            # if this_cart_item.quantity == 0
            #   this_cart_item.status = "retired"
            #   this_cart_item.save
            #   @related_community_products = Product.where(source_product_id: this_cart_item.id)
            #   @related_community_products.each do |community_product|
            #     community_product.status = "retired"
            #     community_product.save
            #   end
            # end

          end
        end
      end

      if order.nil?
        # order = Order.where(shop_id: params[:customer].shop_id).last
        order = Order.where(customer_id: params[:customer].id).last
      else
        order
      end
    else
      raise StandardError, "Unable to capture payment"
    end
  end

  def update_status
    next_status = { 'pending' => 'cancelled',
                    'paid' => 'accepted',
                    'accepted' => 'packed',
                    'packed' => 'pickedup',
                    'pickedup' => 'shipped',
                    'shipped' => 'returned' }
    self.status = next_status[self.status]
    self.save
  end

  def total
    if order_items.present?
      order_items.map {|order_item| order_item.subtotal }.inject(&:+)
    else
      0
    end
  end

  def value
    total + total_discount
  end

  def total_discount
    if order_items.present?
      order_items.map {|order_item| order_item.total_discount }.inject(&:+)
    else
      0
    end
  end

end
