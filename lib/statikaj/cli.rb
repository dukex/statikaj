require 'thor'
require 'erb'
require 'statikaj/article'
require 'statikaj/render'
require 'ext/ext'

module Statikaj
  class CLI < Thor
    desc "build SOURCE [DESTINATION]", "build the blog from source to destination folder"
    long_desc <<-LONGDESC
      The SOURCE folder should have `articles` folders
      DESTINATION default is ./public

      > $ statikaj build ./src
      > $ statikaj build ./src ~/myblog/public
    LONGDESC
    def build(source, destination = "./public")
      source = Pathname.new source
      destination   = Pathname.new destination

      articles_files = Dir[source.join('articles/*.md')].sort_by {|entry| File.basename(entry) }
      articles = articles_files.map{|f| Article.new(f) }

      articles.each do |article|
        article_file = destination.join("#{article.slug}").to_s

        render = Render.new(source, article: article)
        content = render.article do |page|
          page.title = article.title
          page.description = article.summary
        end

        unless File.exists?(article_file)
          file = File.new(article_file, "w+")
          file.puts content
          file.close
        end
      end



      render = Render.new(source, page: 'index', articles: articles.reverse)
      content = render.page
      file = File.new(destination.join("index.html"), "w+")
      file.puts content
      file.close
    end
  end
end
