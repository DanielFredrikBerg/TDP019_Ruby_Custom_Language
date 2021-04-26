require './rules'

file = ARGV[0]

if file == nil
  puts "Running in interactive mode"
  Rules.new.interactive_mode
elsif File.file?(file)
  main = Rules.new

  open_file = File.open( file )
  text = open_file.readlines.map(&:chomp)
  text = text.join(" ")

  main.test(text)
else
  puts "Error when trying to run file: #{file}\n***USAGE***: ruby songic.rb <file_name>\nIf <file name> is omitted, interactive mode (i-mode) will run."
end
