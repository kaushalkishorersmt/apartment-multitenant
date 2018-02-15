class CartsController < ApplicationController

    before_action :find_or_create_cart

    def show
      @product = Product.find(params[:id])
    end


    def update
      this_shop_product = params[:carts][:product_id].to_i
      temp_product = Product.find_by(id: this_shop_product)

      # if temp_product.source == "community"
      #   @this_product = Product.find_by(id: temp_product.source_product_id)
      # else
        @this_product = Product.find_by(id: temp_product.id)
      # end
      #
      if params[:carts][:quantity].present?
        this_quantity = params[:carts][:quantity].to_i
      else
        this_quantity = 1
      end
      #
      if @this_product.quantity.to_i < this_quantity
      #   # byebug
        redirect_to :back, :notice  => "Unfountately we have #{temp_product.quantity} stock available. Please enter quanity equal to or less than this."
      else
        if @this_product.product_properties.pluck(:size).uniq != [""]
          size_required = true
        end
        if @this_product.product_properties.pluck(:color).uniq != [""]
          color_required = true
        end
        notice = ""
      #   #byebug
        if size_required == true
          if params[:carts][:size].nil? || params[:carts][:size] == ""
            size_required_error = true
          end
        end
      #
        if color_required == true
          if params[:carts][:color].nil? || params[:carts][:color] == ""
            color_required_error = true
          end
        end
      #
        if size_required_error == true
          notice = "Size is required to place the order."
        elsif color_required_error == true
          if notice.empty?
            notice = "Color is required to place the order."
          else
            notice = "Size & Color information required to place the order."
          end
        end
      #
        if size_required_error == true || color_required_error == true
          redirect_to :back, :notice => notice
        else
          session[:cart] = current_cart.update(params[:carts])
          if buy_now?
            redirect_to cart_path
          else
            redirect_to product_show_path(params[:carts][:product_id].to_i)
          end
        end
      end
    end

    def checkout_review
      # @billing_address = BillingAddress.find_by(user_id: current_customer.id, primary: true)
      @shipping_address = ShippingAddress.find_by(customer_id: current_customer.id)
      session[:return_to] = request.fullpath
    end

    def checkout_payment
      @billing_address = BillingAddress.find_by(user_id: current_customer.id, primary: true)
      @shipping_address = ShippingAddress.find_by(user_id: current_customer.id, primary: true)
      session[:return_to] = request.fullpath
    end

    def checkout_address
      # byebug
      if current_customer
        @shipping_addresses = ShippingAddress.where(customer_id: current_customer.id)
        @shipping_address = ShippingAddress.new
        session[:return_to] = request.fullpath
      else
        redirect_to new_customer_registration_path
      end
    end


    def remove_item
      session[:cart] = current_cart.remove_item(params[:remove_item])
      redirect_to(:back)
    end

    def destroy
      session[:cart] = current_cart.destroy
      redirect_to root_path, :notice  => "Cart cleared."
    end

    private

      def buy_now?
        params[:commit] == "Buy Now"
      end
end
