require 'rack'

module Statikaj
  class Middleware
    def call(env)
      if env['PATH_INFO'] == '/'
        body = File.open('./index.html', File::RDONLY)
      else
        body = File.open(".#{env['PATH_INFO']}", File::RDONLY)
      end

      [200, {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'public, max-age=86400'
      }, body]
    end
  end
end


use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "."

run Statikaj::Middleware.new
