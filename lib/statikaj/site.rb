module Statikaj
  class Site
    def title
      "KHAOS"
    end

    def render article, &blk
      @context = article
      # TODO: source path
      source = Pathname.new ENV['statikaj_source']
      layout = File.read(source.join('templates/layout.rhtml'))
      ERB.new(layout).result(binding)
    end
  end
end
