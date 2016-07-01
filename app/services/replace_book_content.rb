class ReplaceBookContent
  def self.build
    new
  end

  def call(book, params)
    pdf = Base64EncodedFile.parse(params.fetch(:content_pdf), "book.pdf")
    epub = Base64EncodedFile.parse(params.fetch(:content_epub), "book.epub")
    mobi = Base64EncodedFile.parse(params.fetch(:content_mobi), "book.mobi")
    book.update!(content_pdf: pdf, content_epub: epub, content_mobi: mobi)
    update_chapters(book, params)
  end

  private

  def update_chapters(book, params)
    book.chapters.destroy_all
    params.fetch(:previews).each_with_index do |preview, index|
      book.chapters.create!(
        number: index + 1,
        content_html: Base64.decode64(preview.fetch(:content)),
        title: preview.fetch(:title),
        slug: generate_slug(preview.fetch(:title))
      )
    end
  end

  def generate_slug(title)
    title.parameterize
  end
end
