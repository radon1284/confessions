class MarkdownWrapper
  def display(markdown)
    Kramdown::Document.new(markdown).to_html.html_safe
  end
end
