require 'test/unit'
require 'stringio'
require './rules'

class TestNote < Test::Unit::TestCase  

 ######################################
 #  TESTING THE WRITE FUNCTION.
 ######################################

  def test_write_note_pos_octave
    io = StringIO.new "write 2g+3"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "2g+3", answer )
  end

  def test_write_note_neg_octave
    io = StringIO.new "write 3a-8"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "3a-8", answer )
  end


  def test_write_default_note
    io = StringIO.new "write 4d+4"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "d+4", answer )
  end

  def test_write_sharp_scale
    io = StringIO.new "write bb"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "a#", answer )
  end

  def test_write_flat_scale
    io = StringIO.new "write d#"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "d#", answer )
  end

  def test_write_default_silence
    io = StringIO.new "write 4z"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "z", answer )
  end

  def test_write_silence
    io = StringIO.new "write 7z"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "7z", answer )
  end 

  def test_write_single_silence
    io = StringIO.new "write z"
    out = StringIO.new
    $stdout = out
    Rules.new.run_code io.string
    answer = out.string.strip
    assert_equal( "1z", answer )
  end 
  
  # def test_write_motif
  #   io = StringIO.new "write "
  #   out = StringIO.new
  #   $stdout = out
  #   Rules.new.run_code io.string
  #   answer = out.string.strip
  #   assert_equal( "", answer )
  # end 


end
