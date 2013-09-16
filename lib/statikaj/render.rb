module Statikaj
  class Render
    attr_accessor :title, :articles

    def initialize(options)
      @article = options.delete(:article) if options[:article]
      @articles = options.delete(:articles) if options[:articles]
      if options[:page]
        render_page(options.delete(:page))
      end
    end

    def article(&blk)
      @context = @article
      # TODO: custom title
      @title = @article.title
      to_html &blk
    end

    def page(&blk)
      # TODO: custom description and title
      @context = {description: "TEXT"}
      @title = "TITLE"
      to_html &Proc.new { @page }
    end

    private
      def to_html(&blk)
        # TODO: source path
        source = Pathname.new ENV['statikaj_source']
        layout = File.read(source.join('templates/layout.rhtml'))
        ERB.new(layout).result(binding)
      end

      def render_page(page_name)
        # TODO: source path
        source = Pathname.new ENV['statikaj_source']
        page = File.read(source.join("templates/pages/#{page_name}.rhtml"))
        @page = ERB.new(page).result(binding)
      end
  end
end
