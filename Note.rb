class Note

  def initialize(tone, length: 1, octave: 0)
    @tone = tone
    @length = Rational(1,length)
    @octave = 0 + octave
  end

  def print
    puts @length.denominator.to_s + @tone.to_s + @octave.to_s
  end
  
end

note = Note.new('b', octave: -1)

note.print
