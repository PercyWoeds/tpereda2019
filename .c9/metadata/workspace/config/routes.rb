{"filter":false,"title":"routes.rb","tooltip":"/config/routes.rb","undoManager":{"mark":1,"position":1,"stack":[[{"start":{"row":10,"column":0},"end":{"row":14,"column":3},"action":"insert","lines":["if Rails.env.production?","    get '404', to: 'application#page_not_found'","    get '422', to: 'application#server_error'","    get '500', to:  'application#server_error'","end"],"id":2}],[{"start":{"row":14,"column":3},"end":{"row":15,"column":0},"action":"insert","lines":["",""],"id":3}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":15,"column":0},"end":{"row":15,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":36,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1541467265527,"hash":"0d29e8064be13aa64af4e8c3813dda0309e5fbfa"}