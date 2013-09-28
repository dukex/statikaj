# *Statikaj* <a href='https://gemnasium.com/dukex/statikaj'><img src="https://gemnasium.com/dukex/statikaj.png" alt="Dependency Status" /></a>

Simple static blog-engine based on [cloudhead/toto](https://github.com/cloudhead/toto), perfect for hackers. Like **toto**, *Statikaj* is git-powered


## 10 seconds blog

    $ gem install statikaj
    $ statikaj new myblog
    $ cd myblog
    $ statikaj build
    $ rackup -p 3000 # http://localhost:3000

## Why?

Why you don't need generate your blog every http request. *Statikaj* **don't use database**, **don't parse ERB/Markdown** on production. Build your blog and send a static version to your server, *Statikaj* will works with any http server, you don't need ruby, java, php, etc, a small nginx or apache process will be OK.

## Creating and Writing a article



## Works on your blog design
TODO


## Who uses it?
* [Apartamento131](https://github.com/dukex/apartamento131)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
