# *Statikaj* <a href='https://gemnasium.com/dukex/statikaj'><img src="https://gemnasium.com/dukex/statikaj.png" alt="Dependency Status" /></a>

Simple static blog-engine based on [cloudhead/toto](https://github.com/cloudhead/toto), perfect for hackers. Like **toto**, *Statikaj* is git-powered


## 10 seconds blog

    $ gem install statikaj
    $ statikaj new myblog
    $ cd myblog
    $ statikaj build --url http://myblog.com
    $ rackup -p 3000 # http://localhost:3000

## Why?

Why you don't need generate your blog every http request. *Statikaj* **don't use database**, **don't parse ERB/Markdown** on production. Build your blog and send a static version to your server, *Statikaj* will works with any http server, you don't need ruby, java, php, etc, a small nginx or apache process will be OK.

## Command line

    $ statikaj
    Commands:
      statikaj article          # Create new article
      statikaj build --url=URL  # Build the static blog version on public folder
      statikaj help [COMMAND]   # Describe available commands or one specific command
      statikaj new              # Create a new project



## Creating and Writing a article

Create a article is very easy, first to create a correct file *Statikaj* provides the ```article``` command.

    $ statikaj article

*Statikaj* ```article``` will prompt the article title, and will create a file into ```src/articles```, use your preferred markdown editor open the file. When you finished just builds yout blog again.

    $ statikaj build --url http://myblog.com

### The article file

The article file show like it:

<pre>---
title: My Title
date: 29/09/2013
author: User
category: category

Once upon a time...</pre>

To create a **summary** use ```~~~``` as delimiter, like it:

<pre>---
title: My Title
date: 29/09/2013
author: User
category: category

Once upon a time, there was a lovely princess.

~~~

But she had an enchantment upon her of a fearful sort, which could only be broken by love's first kiss.
</pre>

## Works on your blog design
> TODO, for now see [src/templates](https://github.com/dukex/statikaj/tree/master/templates/src/templates)

## Update

	$ gem install statikaj # or bundle update statikaj
	$ cd myblog
	$ statikaj new . # ATTENTION the command will prompt if you want change yours files, make a backup before!

## Who uses it?
* [Apartamento131](https://github.com/dukex/apartamento131)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
