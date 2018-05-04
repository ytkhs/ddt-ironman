require 'pp'
require_relative '../utils/ironman'

namespace :ih do

  desc "get latest DDT Ironman-Heavymetalweight Champion"
  task :latest, :type do |task, args|
    puts Ironman.new.winners.last.format(args.type)
  end
  
  desc "get all DDT Ironman-Heavymetalweight Champions"
  task :all, :type do |task, args|
    Ironman.new.winners.each do |winner|
      puts winner.format(args.type)
    end
  end
end