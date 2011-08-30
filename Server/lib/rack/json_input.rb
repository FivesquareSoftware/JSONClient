require 'json'

module Rack

	class JSONInput
	
		def initialize(app)
			@app = app
		end

		def call(env)
			if json_request?(env)
				body = env['rack.input'].read
				if !body.empty?
					env.merge!('rack.request.form_hash' =>  JSON.parse(body), 'rack.request.form_input' => env['rack.input'] )
				end
			end
			@app.call(env)
		end
		
		def json_request?(env)
			return true if env['CONTENT_TYPE'] && env['CONTENT_TYPE'] == 'application/json'
			return true if env['Content-type'] && env['Content-type'] == 'application/json'
			false
    end
	
	end

end
