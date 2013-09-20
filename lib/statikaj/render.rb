module Statikaj
  class Render
    attr_accessor :title, :articles, :description

    def initialize(source, options)
      @source = source
      @article = options.delete(:article) if options[:article]
      @articles = options.delete(:articles) if options[:articles]
      if options[:page]
        render_page(options.delete(:page))
      end
    end

    def article(&blk)
      @context = @article
      yield self
      to_html &Proc.new{ @article.render(@source) }
    end

    def page(&blk)
      # TODO: custom description and title
      @context = {description: "TEXT"}
      @title = "TITLE"
      to_html &Proc.new { @page }
    end

    private
      def to_html(&blk)
        layout = File.read(@source.join('templates/layout.rhtml'))
        ERB.new(layout).result(binding)
      end

      def render_page(page_name)
        page = File.read(@source.join("templates/pages/#{page_name}.rhtml"))
        @page = ERB.new(page).result(binding)
      end
  end
end
