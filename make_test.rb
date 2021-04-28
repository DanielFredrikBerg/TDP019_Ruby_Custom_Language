
class MakeTest

  def initialize template = "ztests/Template.rb", expectation = "ztests/expected_outputs.txt"
    @template = template

    @pairs = Array.new
    txt = File.open( expectation ).readlines.map(&:chomp)
    for line in txt
      @pairs << [ line.split[0].to_s, line.split[1..].join(" ") ] 
    end

    # Test file structure
    @header = "# coding: utf-8
require 'test/unit'
require './rules'

class SongicTest < Test::Unit::TestCase\n\n"
    @end = "end"
  end


  def make_test_file
    File.open("Tests_Songic.rb", "w") do |f|
      f << @header
      for pair in @pairs
        template_text = File.open(@template).read
        test_name = pair[0].to_s
        file_name = test_name.gsub(/^test_/,"") + ".song"

        template_text = template_text.gsub(/OOnameOO/, "#{test_name}")
        template_text = template_text.gsub(/OOexpectationOO/, "\"#{pair[1]} \"")
        template_text = template_text.gsub(/OOfileOO/, "#{file_name}")
        f << template_text
      end
      f << @end
    end
  end

end


def main
  #template = ARGV[0]
  #expectation = ARGV[1]
  MakeTest.new().make_test_file
  system("ruby Tests_Songic.rb")

end

main
