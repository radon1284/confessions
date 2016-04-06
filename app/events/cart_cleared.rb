class CartCleared
  attr_accessor :visitor

  def initialize(visitor)
    self.visitor = visitor
  end

  def payload
    {}
  end
end
