post '/test/list' do
	respond(200,params['list'])
end

post '/test/item' do
	respond(200,params)
end
