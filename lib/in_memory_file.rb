class InMemoryFile < StringIO
  attr_accessor :original_filename

  def initialize(content, filename)
    super(content)
    self.original_filename = filename
  end
end
