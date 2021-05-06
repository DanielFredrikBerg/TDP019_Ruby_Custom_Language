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


end