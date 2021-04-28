require './rules'

file = ARGV[0]

if file == nil
  puts "Running in interactive mode"
  Rules.new.interactive_mode


elsif file == "test" 
  Dir.children("./tests").each do |file|
    if file.to_s != "rules.rb" and file.to_s[-1] != "~"
      system("ruby ./tests/#{file}")
    end
  end;nil


elsif File.file?(file)
  main = Rules.new
  
  open_file = File.open( file )
  text = open_file.readlines.map(&:chomp)
  text = text.join(" ")
  
  main.test(text)
else
  puts "Error when trying to run file: #{file}\n***USAGE***: ruby songic.rb <file_name>\nIf <file name> is omitted, interactive mode (i-mode) will run."
end
