require 'json'

module WinnersJson
  def self.generate(winners)
    rows = winners.map { |winner| "  #{JSON.generate(winner.to_h)}" }
    return "[]\n" if rows.empty?

    "[\n#{rows.join(",\n")}\n]\n"
  end
end
