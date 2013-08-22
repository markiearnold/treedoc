module Treedoc
  module RenderingHelper
    def document_path
      request.path
    end

    def document_index_path
      File.join([document_path, "index"])
    end

    def render_document
      begin
        render(:file => document_path).html_safe
      rescue ActionView::MissingTemplate
        render(:file => document_index_path).html_safe
      end
    end
  end
end
