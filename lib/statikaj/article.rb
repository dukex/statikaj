require 'yaml'
require 'statikaj/template'
require 'kramdown'

module Statikaj
  class Article < Hash
    def initialize obj, config = {}
      @obj, @config = obj, config
      self.load #if obj.is_a? Hash
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
          # use the date from the filename, or else toto won't find the article
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

    def summary length = nil
      #   config = @config[:summary]
      #   sum = if self[:body] =~ config[:delim]
      #     self[:body].split(config[:delim]).first
      #   else
      #     self[:body].match(/(.{1,#{length || config[:length] || config[:max]}}.*?)(\n|\Z)/m).to_s
      #   end
      #   markdown(sum.length == self[:body].length ? sum : sum.strip.sub(/\.\Z/, '&hellip;'))
    end

    def url
      #  "http://#{(@config[:url].sub("http://", '') + self.path).squeeze('/')}"
    end
    #alias :permalink url

    def body
      markdown self[:body]
    end

    def path
      # TODO: custom domain
      #  "/#{@config[:prefix]}#{self[:date].strftime("/%Y/%m/%d/#{slug}/")}".squeeze('/')
      slug
    end

    def title()
      self[:title] || "an article"
    end

    def date()
      # TODO: costum
      # @config[:date].call(self[:date])
      self[:date].strftime("%B #{self[:date].day.ordinal} %Y")
    end

    def author()
      self[:author]
    end

    def to_html()
      self.load; super(:article, @config)
    end
    #alias :to_s to_html
  end
end