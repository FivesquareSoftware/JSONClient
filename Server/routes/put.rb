put '/test/list' do
	respond(200,params['list'])
end

put '/test/item' do
	respond(200,params)
end
