require 'rack'

run Rack::Static, :urls => [""], :root => 'public', :index =>'index.html',
  :header_rules => [
    [:all, {'Cache-Control' => 'public, max-age=31536000'}]
  ]
