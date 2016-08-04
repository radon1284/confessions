class GenerateWatermarkedPDF
  NUMBER_OF_PAGES_TO_SKIP = 5

  def self.build
    new
  end

  def call(original_pdf_attachment, email)
    watermark = CombinePDF.parse(WatermarkPDF.new(email).render).pages.first
    pdf = CombinePDF.parse(original_pdf_attachment.read)
    pdf.pages.drop(NUMBER_OF_PAGES_TO_SKIP).each { |page| page << watermark }
    pdf.to_pdf
  end
end
