class CartItem
  attr_reader :product, :quantity, :size, :color

  def initialize(product, quantity, size, color)
    #byebug
    @product = product
    @quantity = quantity
    @size = size
    @color = color
  end

  def title
    product.title
  end

  def unit_price
    product.price
  end

  def selling_price
    product.price
  end

  def percent_off
    product.percent_off
  end

  def on_sale?
    product.on_sale?
  end

  def total
    BigDecimal.new(quantity.to_s) * BigDecimal.new(selling_price.to_s)
  end
end
