# frozen_string_literal: true

class Display_class
  def self.display(entries)
    items =  entries.size
    number = entries.map { |x| x.size }.max
    case number
    when 0..7
      strnum = 8
      colums = 8
    when 8..16
      strnum = 16
      colums = 5
    when 17..24
      strnum = 24
      colums = 3
    when 25..32
      strnum = 32
      colums = 2
    when 33..39
      strnum = 40
      colums = 2
    else
      strnum = 80
      colums = 1
    end
    row = (items / colums.to_f).ceil
    arys = Array.new(row).map { Array.new(colums, " ") }
    itemcount = 0
    (1..colums).each do |num1|
      (1..row).each do |num2|
        arys[num2 - 1][num1 - 1] = entries[itemcount]
        itemcount = itemcount + 1
        if itemcount == items
          break
        end
      end
      if itemcount == items
        break
      end
    end
    (1..row).each do |num1|
      (1..colums).each do |num2|
        unless arys[num1 - 1][num2 - 1].nil?
          print(arys[num1 - 1][num2 - 1].ljust(strnum, " "))
        end
      end
      print("\n")
    end
  end
end
