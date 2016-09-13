class MarkdownWrapper
  # rubocop:disable Rails/OutputSafety
  def display(markdown)
    Kramdown::Document.new(markdown, kramdown_options).to_html.html_safe
  end
  # rubocop:enable Rails/OutputSafety

  private

  def kramdown_options
    { syntax_highlighter: nil,
      input: "GFM" }
  end
end
