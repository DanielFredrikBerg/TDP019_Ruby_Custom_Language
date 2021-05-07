# coding: utf-8
require 'stringio'
require 'test/unit'
require './rules'

class SongicTest < Test::Unit::TestCase

def test_basic_test
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/basic_test.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b ", output.to_s + " " )
end


def test_note_modification_length
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_length.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "2a b ", output.to_s + " " )
end


def test_note_modification_octave_higher
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_octave_higher.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a+1 b ", output.to_s + " " )
end


def test_note_modification_octave_lower
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_octave_lower.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a-1 b ", output.to_s + " " )
end


def test_note_modification_length_and_octave
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_length_and_octave.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "2a+1 b ", output.to_s + " " )
end


def test_note_modification_sharp
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_sharp.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a# b ", output.to_s + " " )
end


def test_note_modification_flat
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_flat.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "g# b ", output.to_s + " " )
end


def test_note_modification_all
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/note_modification_all.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a# 2a# a#+1 2a#+1 a#-1 2a#-1 g# 2g# g#+1 2g#+1 g#-1 2g#-1 ", output.to_s + " " )
end


def test_dumb_notes
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/dumb_notes.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "c+1 e ", output.to_s + " " )
end


def test_several_motifs_in_a_segment
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/several_motifs_in_a_segment.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d e f g ", output.to_s + " " )
end


def test_three_motifs_in_a_segment
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/three_motifs_in_a_segment.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d e f g a b c ", output.to_s + " " )
end


def test_four_motifs_in_a_segment
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/four_motifs_in_a_segment.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d e f g a b c d e f g ", output.to_s + " " )
end


def test_several_segments_in_structure
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/several_segments_in_structure.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d d e f g ", output.to_s + " " )
end


def test_three_segments_in_structure
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/three_segments_in_structure.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d d e f g d e f g ", output.to_s + " " )
end


def test_single_note
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/single_note.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a ", output.to_s + " " )
end


def test_variable_change
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/variable_change.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "d d ", output.to_s + " " )
end


def test_arithmetic_basic_integer
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_basic_integer.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b e d e ", output.to_s + " " )
end


def test_arithmetic_simple_addition
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_simple_addition.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b d# d e ", output.to_s + " " )
end


def test_arithmetic_simple_subtraction
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_simple_subtraction.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b b-1 d e ", output.to_s + " " )
end


def test_arithmetic_simple_multiplication
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_simple_multiplication.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b g# d e ", output.to_s + " " )
end


def test_arithmetic_simple_division
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_simple_division.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b d d e ", output.to_s + " " )
end


def test_arithmetic_combined_add_sub
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_add_sub.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b f# d e ", output.to_s + " " )
end


def test_arithmetic_combined_add_mult
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_add_mult.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b g+1 d e ", output.to_s + " " )
end


def test_arithmetic_combined_add_div
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_add_div.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b f# d e ", output.to_s + " " )
end


def test_arithmetic_combined_div_add
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_div_add.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b g d e ", output.to_s + " " )
end


def test_arithmetic_combined_div_sub
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_div_sub.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c# d e ", output.to_s + " " )
end


def test_arithmetic_combined_sub_div
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_sub_div.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b b d e ", output.to_s + " " )
end


def test_arithmetic_combined_div_mult_parenthesis
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_div_mult_parenthesis.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b f# d e ", output.to_s + " " )
end


def test_arithmetic_combined_mult_add
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_mult_add.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b g+1 d e ", output.to_s + " " )
end


def test_arithmetic_combined_mult_sub
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_mult_sub.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b b d e ", output.to_s + " " )
end


def test_arithmetic_combined_sub_mult
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/arithmetic_combined_sub_mult.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c#-1 d e ", output.to_s + " " )
end


def test_repeat_test
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/repeat_test.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a a a ", output.to_s + " " )
end


def test_repeat_iterations_with_variable
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/repeat_iterations_with_variable.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "c c c ", output.to_s + " " )
end


def test_repeat_iterations_by_variable
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/repeat_iterations_by_variable.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a a ", output.to_s + " " )
end


def test_several_loops
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/several_loops.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "b b ", output.to_s + " " )
end


def test_simple_if_equals
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/simple_if_equals.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c ", output.to_s + " " )
end


def test_simple_if_equals_false
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/simple_if_equals_false.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "c b a ", output.to_s + " " )
end


def test_if_multiple_variable_change
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/if_multiple_variable_change.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "a b c d e f ", output.to_s + " " )
end


def test_for_loop
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/for_loop.song'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG

  assert_equal( "b ", output.to_s + " " )
end


end