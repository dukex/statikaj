require 'rack'

use Rack::Static, :urls => [""], :root => 'public', :index =>'index.html',
  :header_rules => [
    [:all, {'Cache-Control' => 'public, max-age=864000'}],
    [%r{^(?!.*\.).*\w}, {'Content-Type' => 'text/html'}]
  ]

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=864000'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}

