{"filter":false,"title":"application_controller.rb","tooltip":"/app/controllers/application_controller.rb","undoManager":{"mark":1,"position":1,"stack":[[{"start":{"row":4,"column":0},"end":{"row":5,"column":0},"action":"insert","lines":["  after_filter :return_errors, only: [:page_not_found, :server_error]",""],"id":2}],[{"start":{"row":5,"column":0},"end":{"row":24,"column":7},"action":"insert","lines":["def page_not_found","         @status = 404","         @layout = \"application\"","         @template = \"not_found_error\"","    end","","    def server_error","       @status = 500","       @layout = \"error\"","       @template = \"internal_server_error\"","    end","","    private","","    def return_errors","        respond_to do |format|","              format.html { render template: 'errors/' + @template, layout: 'layouts/' + @layout, status: @status }","              format.all  { render nothing: true, status: @status }","        end","    end"],"id":3}]]},"ace":{"folds":[],"scrolltop":127,"scrollleft":0,"selection":{"start":{"row":24,"column":7},"end":{"row":24,"column":7},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":36,"mode":"ace/mode/ruby"}},"timestamp":1541467290160,"hash":"64fdae28cb52d8260729ce17e4140cad1a75b846"}