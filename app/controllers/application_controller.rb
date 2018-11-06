class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :return_errors, only: [:page_not_found, :server_error]
def page_not_found
         @status = 404
         @layout = "application"
         @template = "not_found_error"
    end

    def server_error
       @status = 500
       @layout = "error"
       @template = "internal_server_error"
    end

    private

    def return_errors
        respond_to do |format|
              format.html { render template: 'errors/' + @template, layout: 'layouts/' + @layout, status: @status }
              format.all  { render nothing: true, status: @status }
        end
    end
  
end
