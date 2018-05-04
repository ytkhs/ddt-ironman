require 'date'
class Winner
	attr_accessor :num, :name, :date
	
	def initialize(num, date, name)
		@num = num.strip.delete("^0-9")
		@name = name.strip
		@date = Date.parse(date.strip.gsub('.', '/')) rescue nil
	end
	
	def disp_line
		 sprintf("#%s %s %s", @num.ljust(5), @date&.strftime('%Y-%m-%d'), @name)
	end
	
	def csv_row
		 [@num, @date&.strftime('%Y-%m-%d'), @name].join(',')
	end
end