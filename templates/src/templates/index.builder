xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title title
  xml.id "urn:md5:#{Digest::MD5.hexdigest(url)}"
  xml.updated articles.first[:date].iso8601 unless articles.empty?
  xml.author { xml.name "A" }
  xml.link "rel" => "self", "href" => "#{url}/feed.atom", "type" => "application/atom+xml"
  xml.link "rel" => "alternate", "href" => url, "type" => "text/html"
  xml.generator "Statikaj", "uri" => "https://github.com/dukex/statikaj", "version" => Statikaj::VERSION

  articles.reverse[0...10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id "urn:md5:#{Digest::MD5.hexdigest(article.url)}"
      xml.published article[:date].iso8601
      xml.updated article[:date].iso8601
      xml.author { xml.name article[:author] }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
