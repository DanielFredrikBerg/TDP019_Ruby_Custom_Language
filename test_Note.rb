require 'test/unit'
require 'stringio'
require './Note'
require './rules'

class TestNote < Test::Unit::TestCase

  @@songic = Rules.new

  # Does not work the way I think it works.

  def test_note_write
    io = StringIO.new "write 2a+3"
    out = StringIO.new
    $stdout = out
    answer = @@songic.run_code io.string
    puts "ANSWER #{answer}"
    assert_equal( "2g3", answer ) 
    
    

  end


end
