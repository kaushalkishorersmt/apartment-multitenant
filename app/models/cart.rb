class Cart 
  attr_reader :session

  def initialize(session)
    #byebug
    @session = session
  end

  def items
    #session.map do |id, quantity, size, color|
    session.map do |id, quantity, size, color|
      #byebug
      CartItem.new(Product.find(id), quantity[0], quantity[1], quantity[2])
    end
  end

  def total
    items.map { |item| item.total }.inject(&:+)
  end

  def remove_item(remove_item_param)
    if id = remove_item_param[:product_id]
      session.delete(id)
    end
    session
  end

  def update(carts_param)
    #byebug
    if id = carts_param[:product_id]
      quantity = carts_param[:quantity]
      size = carts_param[:size]
      color = carts_param[:color]
      if session[id].nil?
        tquantity = quantity || (session[id].to_i + 1).to_s
      else
        tquantity = quantity || (session[id][0].to_i + 1).to_s
      end
      session[id] = tquantity, size, color
    end
    session
  end

  def destroy
    session = {}
  end

  def count
    session.present? ? "(#{calculate_count})" : nil
  end

  def empty?
    items.empty?
  end

private
  def calculate_count
    #session.values.map(&:to_i).reduce(&:+)
    if session.values.length > 1
      session.map { |x, y| y[0].to_i }.reduce :+
    else
      session.values[0][0].to_i
    end
  end
end
