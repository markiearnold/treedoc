module Treedoc
  class DocumentsController < Treedoc::ApplicationController
    def show
      render :action => :show, :layout => true
    end
  end
end
