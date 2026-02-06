require 'nokogiri'
require 'open-uri'
require 'kconv'
require 'pp'
require_relative './winner'

class Ironman

  URL_DDT_TITLE = "https://extremeparty.heteml.net/title.html"
  attr_accessor :winners
  
  def initialize
    html = URI.open(URL_DDT_TITLE).read
    doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
    @winners = []
    
    doc.xpath('//a[@name="ironman"]').each do |item|
      # 歴代のテーブル
      node = item.next_element
      while node && !['a', 'hr'].include?(node.name.downcase)
        if node.name.downcase == 'table'
          node.xpath('tr').each do |tr|
            tds = tr.xpath('td')
            next if tds.empty?
            @winners << Winner.new(
              tds[0] ? tds[0].text : '',
              tds[1] ? tds[1].text : '',
              tds[2] ? tds[2].text : ''
            )
          end
        end
        node = node.next_element
      end
    end
  end
end