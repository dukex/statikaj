require 'thor'
require 'erb'
require 'statikaj/article'
require 'statikaj/site'
require 'ext/ext'

module Statikaj
  class CLI < Thor
    desc "build a", "build b"
    def build
      # TODO: source path
      source = Pathname.new ENV['statikaj_source']
      # TODO: custom destination
      destination = Pathname.new ENV['statikaj_destination']
      # TODO: config ext
      # TODO: config articles path
      articles_files = Dir[source.join('articles/*.md')].sort_by {|entry| File.basename(entry) }

      articles = articles_files.map{|f| Article.new(f) }

      site = Site.new

      articles.each do |article|
        # TODO: custom destination
        article_file = destination.join("public/#{article.slug}").to_s

        content = site.render articles.first, &Proc.new { articles.first.render }

        unless File.exists?(article_file)
          file = File.new(article_file, "w+")
          file.puts content
          file.close
        end
      end
    end
  end
end
