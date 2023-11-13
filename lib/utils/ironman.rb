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
      table = item.next_element.next_element
      table.xpath('tr').each do |tr|
        td = tr.children
        @winners << Winner.new(
          td[0] ? td[0].text : '',
          td[1] ? td[1].text : '',
          td[2] ? td[2].text : ''
        )
      end
    end
  end
end