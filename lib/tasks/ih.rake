require 'pp'
require_relative '../utils/ironman'
require_relative '../utils/winners_json'

namespace :ih do

  desc "get latest DDT Ironman-Heavymetalweight Champion"
  task :latest, :type do |task, args|
    puts Ironman.new.winners.last.format(args.type)
  end
  
  desc "get all DDT Ironman-Heavymetalweight Champions"
  task :all, :type do |task, args|
    winners = Ironman.new.winners
    if args.type == 'json'
      puts WinnersJson.generate(winners)
    else
      winners.each do |winner|
        puts winner.format(args.type)
      end
    end
  end

  desc "update winners.json"
  task :update do
    winners = Ironman.new.winners
    File.write('data/winners.json', WinnersJson.generate(winners))
    puts "Updated data/winners.json with #{winners.size} winners."
  end
end
