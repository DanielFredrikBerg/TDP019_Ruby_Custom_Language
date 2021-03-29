require './rules'

file = ARGV[0]


if File.file?(file)
  main = Rules.new(file)
  main.compile_and_run
else
  puts "Error when trying to run file: #{file}"
end
