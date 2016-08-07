class GenerateWatermarkedEPUB
  def self.build
    new
  end

  def call(original_epub_attachment, email)
    Tempfile.open do |file|
      file.binmode
      file.write(original_epub_attachment.read)

      epub = EPUB::Parser.parse(file.path)
      append_to_title_page(epub, email)

      File.read(file.path)
    end
  end

  private

  def append_to_title_page(epub, email)
    title_page = epub.resources.find do |resource|
      resource.entry_name == "title_page.xhtml"
    end
    title_page.edit_with_nokogiri do |doc|
      doc.at_css("body") << "Prepared exclusively for #{email}"
    end
  end
end
