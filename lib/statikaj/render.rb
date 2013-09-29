require 'erb'
require 'builder'
require 'statikaj/version'
module Statikaj
  class Render
    attr_accessor :title, :articles, :description, :url, :category

    def initialize(source, options)
      @source = source
      @article = options.delete(:article) if options[:article]
      @articles = options.delete(:articles) if options[:articles]
      @type = options.fetch(:type, :html)
      if options[:page] && @type == :html
        render_page(options.delete(:page))
      end
    end

    def article(&blk)
      yield self
      to_html do
        @article.render(@source)
      end
    end

    def page(&blk)
      yield self
      send("to_#{@type}"){ @page }
    end

    private
      def to_html(&blk)
        layout = File.read(@source.join('templates/layout.rhtml'))
        ERB.new(layout).result(binding)
      end

      def to_atom
        xml = Builder::XmlMarkup.new(:indent => 2)
        instance_eval  File.read(@source.join("templates/index.builder"))
      end

      def render_page(page_name)
        page = File.read(@source.join("templates/pages/#{page_name}.rhtml"))
        @page = ERB.new(page).result(binding)
      end
  end
end
