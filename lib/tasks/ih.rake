require 'pp'
require_relative '../utils/ironman'

namespace :ih do

	desc "get latest DDT Ironman-Heavymetalweight Champion"
	task :latest do
	 	Ironman.new.winners.last.disp_line
	end
	
	desc "get all DDT Ironman-Heavymetalweight Champions"
	task :all do
	 	Ironman.new.winners.each do |winner|
			puts winner.disp_line
		end
	end
end