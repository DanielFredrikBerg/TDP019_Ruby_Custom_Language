class Note

  def initialize(length, tone, octave)

    @length = Rational(1,length)
    @tone = tone
    @octave = 0 + octave
    
  end

  def print
      puts @length.denominator.to_s + @tone.to_s + @octave.to_s + " "
    end
  end
  
end

note = Note.new(2,'b',-1)

note.transpose.print
