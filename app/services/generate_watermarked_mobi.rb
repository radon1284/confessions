class GenerateWatermarkedMOBI
  class EBookConvertFailed < RuntimeError; end

  def self.build
    new(DI.get(GenerateWatermarkedEPUB))
  end

  def initialize(generate_watermarked_epub)
    self.generate_watermarked_epub = generate_watermarked_epub
  end

  def call(epub_attachment, email)
    epub_content = generate_watermarked_epub.call(epub_attachment, email)

    Tempfile.open(["epub", ".epub"]) do |input|
      input.binmode
      input.write(epub_content)

      Tempfile.open(["mobi", ".mobi"]) do |output|
        convert_epub_to_mobi(input, output)
        File.read(output.path)
      end
    end
  end

  private

  attr_accessor :generate_watermarked_epub

  def convert_epub_to_mobi(input, output)
    command_output = `ebook-convert #{input.path} #{output.path} 2>&1`
    raise(EBookConvertFailed, command_output) unless $CHILD_STATUS.success?
  end
end
