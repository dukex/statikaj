require 'yaml'
require 'statikaj/template'
require 'kramdown'

module Statikaj
  class Article < Hash
    def initialize obj, config
      @obj, @config = obj, config
      self.load
    end

    def render(source)
      ERB.new(File.read(source.join("templates/pages/article.rhtml"))).result(binding)
    end

    def markdown(text)
      Kramdown::Document.new(text).to_html
    end

    def load
      data = if @obj.is_a? String
          meta, self[:body] = File.read(@obj).split(/\n\n/, 2)
          @obj =~ /\/(\d{4}-\d{2}-\d{2})[^\/]*$/
          ($1 ? {:date => $1} : {}).merge(YAML.load(meta))
        elsif @obj.is_a? Hash
          @obj
        end.inject({}) {|h, (k,v)| h.merge(k.to_sym => v) }

      self.taint
      self.update data
      self[:date] = Date.parse(self[:date].gsub('/', '-')) rescue Date.today
      self
    end

    def [] key
      self.load unless self.tainted?
      super
    end

    def slug
      self[:slug] || self[:title].slugize
    end

    def summary
      sum = self[:body].split("~~~").first
      markdown(sum.length == self[:body].length ? sum : sum.strip.sub(/\.\Z/, '&hellip;'))
    end

    def url
      "http://#{(@config[:url].sub("http://", '') + self.path).squeeze('/')}"
    end
    alias :permalink url

    def body
      markdown self[:body].sub("~~~", '')
    end

    def path
      "/#{slug}"
    end

    def title
      self[:title] || "an article"
    end

    def date
      self[:date]
    end

    def author()
      self[:author]
    end

    def to_html()
      self.load; super(:article, @config)
    end
    alias :to_s to_html
  end
end
