class MarkdownWrapper
  def display(markdown)
    Kramdown::Document.new(markdown, kramdown_options).to_html.html_safe
  end

  private

  def kramdown_options
    {syntax_highlighter: nil,
     input: "GFM"}
  end
end
