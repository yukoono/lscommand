# frozen_string_literal: true

require "etc"

class Options_long
  def self.entry_long(entry, s)
    t = s.mtime
    str1 = " " + t.month.to_s.rjust(2, " ") + " " + t.day.to_s.rjust(2, " ")
    str1 += " " + t.hour.to_s.rjust(2, "0") + ":" + t.min.to_s.rjust(2, "0") + " "
    entry.insert(1, str1)
    entry.insert(1, s.size.to_s(10).rjust(6, " "))
    str2 = " " + Etc.getpwuid(s.uid).name + " " + Etc.getgrgid(s.gid).name
    entry.insert(1, str2)
    entry.insert(1, s.nlink.to_s(10).rjust(4, " "))
    stat = s.mode.to_s(2)
    stat.reverse!
    (1..3).each do |num1|
      (1..3).each do |num2|
        if stat[(num1 - 1) * 3 + num2 - 1] == "1"
          case num2
          when 1
            entry.insert(1, "x")
          when 2
            entry.insert(1, "w")
          else
            entry.insert(1, "r")
          end
        else
          entry.insert(1, "-")
        end
      end
    end
    entry
  end

  def self.display_long(entries, blocksize)
    str3 = "total " + blocksize.to_s(10)
    puts str3
    puts entries.join("\n")
  end
end
