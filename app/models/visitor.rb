class Visitor
  attr_reader :identifier

  def initialize(identifier)
    self.identifier = identifier
  end

  private

  attr_writer :identifier
end
