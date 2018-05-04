require 'date'
class Winner
	attr_accessor :num, :name, :date
	
	def initialize(num, date, name)
		@num = num.strip.delete("^0-9")
		@name = name.strip
		@date = Date.parse(date.strip.gsub('.', '/')) rescue nil
	end
	
	def disp_line
		 puts sprintf("#%s %s %s", @num.ljust(5), @date&.strftime('%Y-%m-%d'), @name)
	end
end