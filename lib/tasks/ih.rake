require 'pp'
require_relative '../utils/ironman'

namespace :ih do

  desc "get latest DDT Ironman-Heavymetalweight Champion"
  task :latest, :type do |task, args|
    puts Ironman.new.winners.last.format(args.type)
  end
  
  desc "get all DDT Ironman-Heavymetalweight Champions"
  task :all, :type do |task, args|
    winners = Ironman.new.winners
    if args.type == 'json'
      puts JSON.pretty_generate(winners.map(&:to_h))
    else
      winners.each do |winner|
        puts winner.format(args.type)
      end
    end
  end

  desc "update winners.json"
  task :update do
    winners = Ironman.new.winners
    File.write('data/winners.json', JSON.pretty_generate(winners.map(&:to_h)))
    puts "Updated data/winners.json with #{winners.size} winners."
  end
end