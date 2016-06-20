class MarkdownWrapper

  def display(markdown)
    options = {
      filter_html:     true,
      hard_wrap:       false,
      link_attributes: { target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown_engine = Redcarpet::Markdown.new(renderer, extensions)

    markdown_engine.render(markdown).html_safe
  end

end
