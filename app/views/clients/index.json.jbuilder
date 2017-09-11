json.array!(@clients) do |client|
  json.extract! client, :id, :vcodigo, :vruc, :vrazon2, :vdireccion, :vdistrito, :vprov, :vdep, :mailclient , :mailclient2, :mailclient3 
  json.url client_url(client, format: :json)
end
