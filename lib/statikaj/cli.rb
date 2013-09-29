require 'thor'
require 'statikaj/article'
require 'statikaj/render'
require 'ext/ext'

module Statikaj
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../../..', __FILE__)
    end

    desc 'new', 'Create a new project'
    def new(name)
      directory('templates', name, verbose: true)
    end

    desc "build", "Build the static blog version on public folder"
    option :force, :type => :boolean, default: false, aliases: :f, desc: "force rebuild olds articles"
    option :url, :type => :string, required: true, desc: "base blog url"
    option :"no-category", :type => :boolean, default: false, desc: "without category support"
    long_desc <<-LONGDESC
      > $ statikaj build --url http://myblog.com
      > $ statikaj build --no-category --url http://myblog.com
      > $ statikaj build -f --url http://myblog.com
    LONGDESC
    def build
      source      = Pathname.new "./src"
      destination = Pathname.new "./public"

      config = {}
      config[:url] = options[:url].split("/").join("/")

      articles_files = Dir[source.join('articles/*.md')].sort_by {|entry| File.basename(entry) }
      articles = articles_files.map{|f| Article.new(f, config) }
      categories = {}

      articles.each do |article|
        categories[article.category] ||= []
        categories[article.category] << article

        article_file = destination.join("#{article.slug}").to_s

        render = Render.new(source, article: article)
        content = render.article do |page|
          page.title = article.title
          page.description = article.summary
        end

        create_file article_file, content, force: options[:force]
      end

      render = Render.new(source, page: 'index', articles: articles.reverse)
      content = render.page {}
      create_file destination.join("index.html"), content, force: true

      render = Render.new(source, page: 'index', articles: articles.reverse, type: :atom)
      atom_content = render.page do |page|
        page.url = config[:url]
      end
      create_file destination.join("feed.atom"), atom_content, force: true

      unless options[:"no-category"]
        empty_directory destination.join("category")
        categories.each do |key, _articles|
          key = "No Category" if key.nil?
          slug = key.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

          render = Render.new(source, page: 'category', url: slug, articles: _articles.reverse)
          content = render.page {}
          create_file destination.join("category/#{slug}"), content, force: true
        end
      end
    end

    desc "article", "Create new article"
    def article
      title = ask('Title: ')
      slug = title.empty?? nil : title.strip.slugize

      article = {'title' => title, 'date' => Time.now.strftime("%d/%m/%Y"), 'author' => 'User', 'category' => 'category'}.to_yaml
      article << "\n"
      article << "Once upon a time...\n\n"
      path = "src/articles/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.md"
      unless File.exist? path
        begin
          File.open(path, "w") do |file|
            file.write article
          end
          say "An article was created for you at #{path}.", :green
        rescue
          say "Impossible to create #{path}, make sure you are in project root", :red
        end
      else
        say "I can't create the article, #{path} already exists.", :red
      end
    end
  end
end
