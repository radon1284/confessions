class OrderCompleted
  attr_accessor :visitor
  attr_accessor :order

  def initialize(visitor, order)
    self.visitor = visitor
    self.order = order
  end

  def payload
    {
      order_id: order.id
    }
  end
end
