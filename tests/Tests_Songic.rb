# coding: iso-8859-1
require 'test/unit'
require_relative '../rules.rb'

class Test < Test::Unit::TestCase

def test_basic_test
  assert_equal( "a b", Rules.new.test( "basic_test.song" )  )
end


def test_note_modification_length
  assert_equal( "2a b", Rules.new.test( "note_modification_length.song" )  )
end


def test_note_modification_octave_higher
  assert_equal( "a+1 b", Rules.new.test( "note_modification_octave_higher.song" )  )
end


def test_note_modification_octave_lower
  assert_equal( "a-1 b", Rules.new.test( "note_modification_octave_lower.song" )  )
end


def test_note_modification_length_and_octave
  assert_equal( "2a+1 b", Rules.new.test( "note_modification_length_and_octave.song" )  )
end


def test_note_modification_sharp
  assert_equal( "a# b", Rules.new.test( "note_modification_sharp.song" )  )
end


def test_note_modification_flat
  assert_equal( "g# b", Rules.new.test( "note_modification_flat.song" )  )
end


def test_note_modification_all
  assert_equal( "a# 2a# a#+1 2a#+1 a#-1 2a#-1 g# 2g# g#+1 2g#+1 g#-1 2g#-1", Rules.new.test( "note_modification_all.song" )  )
end


def test_dumb_notes
  assert_equal( "c+1 e", Rules.new.test( "dumb_notes.song" )  )
end


def test_several_motifs_in_segment
  assert_equal( "a b c d e f g", Rules.new.test( "several_motifs_in_segment.song" )  )
end


def test_several_segments_in_structure
  assert_equal( "a b c d d e f g", Rules.new.test( "several_segments_in_structure.song" )  )
end


def test_arithmetic_basic_integer
  assert_equal( "a b e d e", Rules.new.test( "arithmetic_basic_integer.song" )  )
end


def test_arithmetic_simple_addition
  assert_equal( "a b d# d e", Rules.new.test( "arithmetic_simple_addition.song" )  )
end


def test_arithmetic_simple_subtraction
  assert_equal( "a b b-1 d e", Rules.new.test( "arithmetic_simple_subtraction.song" )  )
end


def test_arithmetic_simple_multiplication
  assert_equal( "a b g# d e", Rules.new.test( "arithmetic_simple_multiplication.song" )  )
end


def test_arithmetic_combined_add_sub
  assert_equal( "a b f# d e", Rules.new.test( "arithmetic_combined_add_sub.song" )  )
end


def test_arithmetic_combined_add_mult
  assert_equal( "a b g+1 d e", Rules.new.test( "arithmetic_combined_add_mult.song" )  )
end


def test_arithemtic_combined_mult_add
  assert_equal( "a b g+1 d e", Rules.new.test( "arithemtic_combined_mult_add.song" )  )
end


def test_arithmetic_combined_mult_sub
  assert_equal( "a b b d e", Rules.new.test( "arithmetic_combined_mult_sub.song" )  )
end


def test_arithemtic_combined_sub_mult
  assert_equal( "a b c#-1 d e", Rules.new.test( "arithemtic_combined_sub_mult.song" )  )
end


end