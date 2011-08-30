class Object
	def json_proxy
		case self
		when Exception
			{ :name => self.class.name, :message => self.message, :backtrace => self.backtrace }
		when String
			self
		when Integer
			self
		when Hash
			self
		when Array
			ProxyArray.new(self)
		else
			raise "Cannot turn a #{self.class.name} into json"
		end
	end
end