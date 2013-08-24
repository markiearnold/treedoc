module Treedoc
  module RenderingHelper

    # Renders the contents of the requested markdown document anywhere within
    # your view template. Treedoc does this out-of-the-box with a simple view, 
    # which you can override in /app/views/treedoc/show.html.erb:
    #
    #   <%= render_document %>
    #
    # Given a request URI for /guide/getting_started/sign_up, Treedoc will
    # attempt to render guide/getting_started/sign_up.md somehwere in Rails'
    # multiple view paths.
    #
    # Typically, this will be /app/views/guide/getting_started/sign_up.md, but 
    # gems can also provide this file in their view path (see README).
    #
    # If that file does not exist in the view paths, an 
    # ActionView::MissingTemplate error will be raised. In a development 
    # environment you'll see this exception. In a production app, this is 
    # usually caught by Rails and presented as a 404 error to the user.
    def render_document
      render(:file => request_path).html_safe
    end

    protected

    # TODO: Might want to normalize or santize the path?
    def request_path
      request.path
    end

  end
end
