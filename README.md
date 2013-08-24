# Treedoc

Treedoc helps you render a tree structure of Markdown documents as web pages inside your Rails app's existing layouts. Documents can be stored in your existing `app/views` structure or in an external git repository (shifting the idea of a "CMS" to Github's public and private collaboration tools).


## Installation

Add Treedoc to your Rails app's Gemfile:

    gem 'treedoc'

Run bundle install:

    $ bundle install


## Example

Let's say you want to add some FAQs to your app with a URL structure of `/faqs/{category}/{title}` and `/faqs/{category}/{category}/{title}`.

Set-up route that targets `/faqs` in `config/routes.rb`

    get '/:treedoc(/*path)' => 'treedoc/documents#show', constraints: { :treedoc => /faqs/ }

Set-up your document tree:

    app/
      views/
        faqs.md
        faqs/
          your_account.md
          your_account/
            registering_your_account.md
            cancelling_your_account.md
          purchasing.md
          purchasing/
            payment_methods.md
            returns_policy.md
            licenses.md
            licenses/
              basic.md
              fancy.md

These URLs will all now work, rendering the appropriate document inside your application's main layout, through Redcarpet's Markdown parser:

    /faqs
    /faqs/your_account
    /faqs/your_account/registering_your_account.md
    /faqs/your_account/cancelling_your_account.md
    /faqs/purchasing
    /faqs/payment_methods
    /faqs/returns_policy
    /faqs/licenses
    /faqs/licenses/basic
    /faqs/licenses/fancy
    
Any missing documents (eg `/faqa/whatever`) will raise a standard `ActionView::TemplateNotFound` error, which is generally rendered by Rails as  a 404 error in production.

An example application can be [found here](https://github.com/justinfrench/treedoc_example).


## Caveats (or benefits, depending on your perspective)

Treedoc doesn't impose any specific user interface or user experience into your documents. It doesn't assume the ordering of documents, it doesn't generate index files or interface widgets for navigation.

It's up to you to create your own links between the documents, introduce each section and guide your users through your pages. It's a bit of manual work, but you get exactly what you need.

Future releases _may_ provide some helpers for breadcrumbs, indexes, etc.


## Customising the view

By default, Treedoc renders in a very basic view (provided in the gem) containing only the parsed contents of your Markdown document:

    # default show.html.erb
    <%= render_document %>

You can override this with your own custom view to add extra headings, markup or navigation:

    # app/views/treedoc/documents/show.html.erb
    <h1>Frequently Asked Questions</h1>
    <div id="faq-document">
      <%= render_document %>
    </div>

## Customising which layout is used with the view

By default, Treedoc's controller will inherit from your `ApplicationController`, so it will probably use `app/views/layouts/application.html.erb`. You can modify this by overriding and inheriting from Treedoc's controller and updating your routes to point to it:

    # config/routes.rb
    get '...' => 'documents#show', constraints: { ... }

    # app/controllers/documents_controller.rb
    class DocumentsController < Treedoc::DocumentsController
      layout "whatever"
    end
    
## Extracting your documents to a separate git repository

Treedoc is taking advantage of Rails templating system, which means your documents can be extracted out to a separate git repository containing the same `app/views/faqs` structure and a few other files to help Rails recognise this as a Rails Engine gem.

While Rails expects a gem, you can use Bundler's `:git` option rather than actually publishing a gem on RubyGems.org.

This allows you to invite contributions using Github's online collaboration and versioning tools (adding and editing files, submitting pull requests, etc) whilst keeping the rest of your application's code private.

    # Gemfile
    gem 'faqs', :git => 'https://github.com/justinfrench/treedoc-content-example.git'
    
An example document repository can be [found here](https://github.com/justinfrench/treedoc_content_example).


## Project Status

* not yet battle-tested in a large-scale production app
* only tested with Rails 4.0.0
* no automated tests exist yet (testing Rails Engine behaviour is "fun")


## Contributing

Issues can be reported [on Github](https://github.com/justinfrench/treedoc). 

New features requests and changes are welcome in the form of a Pull Request on Github:

* fork the code on Github
* make a new branch
* commit your changes
* send a pull request


## Boring legal stuff

Copyright (c) 2013 Justin French.
Released under an MIT license (see MIT-LICENSE for more details).