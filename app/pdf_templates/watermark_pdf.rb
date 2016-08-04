class WatermarkPDF
  include Prawn::View

  def initialize(email)
    self.email = email
    self.document = Prawn::Document.new(bottom_margin: 0)
  end

  def render
    move_cursor_to 15
    text("Prepared exclusively for #{email}")
    super
  end

  private

  attr_accessor :email, :document
end
