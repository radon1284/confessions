#encoding: UTF-8

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Jack-Kinsella.ie"
    xml.author "Jack Kinsella"
    xml.description "Online marketing, Software, Technology for Self-Improvement"
    xml.link "https://www.jackkinsella.ie"
    xml.language "en"

    articles.each do |article|
      xml.item do
        xml.title article.title
        xml.author "Jack Kinsella"
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article.slug)
        xml.guid article.id
        xml.description "<p>" +  MarkdownWrapper.new.display(article.body)  + "</p>"
      end
    end
  end
end
