module Statikaj
  class Render
    attr_accessor :title

    def initialize(options)
      @article = options.delete(:article) if options[:article]
    end

    def article(&blk)
      @context = @article
      # TODO: custom title
      @title = @article.title
      # TODO: source path
      source = Pathname.new ENV['statikaj_source']
      layout = File.read(source.join('templates/layout.rhtml'))
      ERB.new(layout).result(binding)
    end
  end
end
