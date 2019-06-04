# frozen_string_literal: true

require "./options_long.rb"
require "./display.rb"
require "optparse"

options = ARGV.getopts("alrF")
target = ARGV[0] || Dir.pwd

entries = Dir.entries(target)

if options["a"]
  options["a"] = false
else
  entries.select! { |entry| entry[0] != "." }
end

entries.sort!
blocksize = 0

if options["r"]
  entries.reverse!
end

if options.value? true
  entries.map! do |entry|
    fullpath = "#{target}/#{entry}"
    case
    when File.directory?(fullpath)
      entry += "/" if options["F"]
      entry = "d " + entry if options["l"]
    when File.symlink?(fullpath)
      entry += "@" if options["F"]
    when File.executable?(fullpath)
      entry += "*" if options["F"]
    when File.file?(fullpath)
      entry = "- " + entry if options["l"]
    end
    if options["l"]
      s = File.stat(fullpath)
      blocksize = blocksize + s.blocks
      entry = Options_long.entry_long(entry, s)
    end
    entry
  end
end

if options["l"]
  Options_long.display_long(entries, blocksize)
else
  Display_class.display(entries)
end
