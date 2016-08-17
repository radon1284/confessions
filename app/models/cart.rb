class Cart
  attr_reader :items

  def initialize(items)
    self.items = items
  end

  def display_description
    items.map(&:display_name).join(", ")
  end

  def total
    items.map(&:price).sum
  end

  private

  attr_writer :items
end
