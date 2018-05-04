require 'date'
require 'json'

class Winner
	attr_accessor :num, :name, :date
	
	def initialize(num, date, name)
		@num = num.strip.delete("^0-9")
		@name = name.strip
		@date = Date.parse(date.strip.gsub('.', '/')) rescue nil
	end
	
	def format(type = 'human')
		case type
		when 'csv'
			[@num, @date&.strftime('%Y-%m-%d'), @name].join(',')
		when 'json'
			JSON.pretty_generate(['number' => @num, 'date' => @date&.strftime('%Y-%m-%d'), 'name' => @name])
		else
			return sprintf("#%s %s %s", @num.ljust(5), @date&.strftime('%Y-%m-%d'), @name)
		end
	end
end