require 'date'
require 'json'

class Winner
  attr_accessor :num, :name, :date
  
  def initialize(num, date, name)
    num = num.strip
    begin
      @num = Integer(num.strip.delete("^0-9"))
    rescue
      @num = num # 「暫定」など数字じゃない場合がある
    end
    @name = name.strip
    @date = Date.parse(date.strip.gsub('.', '/')) rescue nil
  end
  
  def to_h
    {
      'number' => @num,
      'date' => @date&.strftime('%Y-%m-%d'),
      'name' => @name
    }
  end

  def format(type = 'human')
    case type
    when 'csv'
      [@num, @date&.strftime('%Y-%m-%d'), @name].join(',')
    when 'json'
      JSON.pretty_generate(to_h)
    else
      return sprintf("#%s %s %s", @num.to_s.ljust(5), @date&.strftime('%Y-%m-%d'), @name)
    end
  end
end