helpers do


	# Responders
	
	def respond(status,object)
		content_type('application/json')
		status(status)
		object.json_proxy
	end
	
	def ok(body={})
		respond(200,body)
	end
	
	def created(body={})
		respond(201,body)
	end
	
	def bad_request(body={})
		respond(400,body)
	end
	
	def unauthorized(body={})
		response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth")
		respond(401, body)
	end
	
	def forbidden(body={})
		respond(403,body)
	end

	def not_found(body={})
		respond(404,body)
	end 

	def unprocessable_entity(body={})
		respond(422,body)
	end
	
	def server_error(body={})
		respond(500,body)
	end
	
	
	
	# Auth
	
	def protected!
		# response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth") and
		# throw(:halt, [401, "Not authorized\n"]) and
		# return unless authorized?
		halt(unauthorized('Not Authorized')) unless authorized?
	end

	def authorized?
		@auth ||=	 Rack::Auth::Basic::Request.new(request.env)
		@auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['test', 'test']
	end

	# Fixtures
	
	def item
		{
			:device => {
				:udid => '97cf53ebf930b5c6a134edfa0b90eb72b2edc38b', 
				:alias => 'jPhone', 
				:token => 'CBADEBDEEFBECEDCFCFADFBCEBBFFECACCEFABECFDFCBAFCDEBFFAFCDBFCFDBF',
				:imei => '01 161200 615390 1',
				:network => 'verizon',
				:serial_number => '87831LUY7K',
				:version => 10,
				:applications => [{:name => 'MyApp'},{:name => 'MyApp'}],
				:last_updated => '2009-09-07T09:47:19Z'
			}
		}
	end
	
	def list(count=5)		
		items = (1..count).collect {
			self.item[:device]
		}
	end
	
end