require 'pp'
require 'nokogiri'
require 'open-uri'
require 'kconv'

namespace :ih do

	desc "get latest DDT Ironman-Heavymetalweight Champion"
	task :latest do
		
		uri = "http://extremeparty.heteml.jp/title.html"
		html = open(uri).read
		
		doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
		
		doc.xpath('//a[@name="ironman"]').each do |item|
			# 歴代のテーブル
			table = item.next_element.next_element
			# 最終保持者
			data = table.xpath('tr').last.children
			hash = {
				date: data[1] ? data[1].text.ljust(10) : '',
				num: data[0] ? data[0].text.ljust(5) : '',
				name: data[2] ? data[2].text : '',
			}
			puts sprintf("%{date} %{num}　%{name}", hash)
		end
	end
end