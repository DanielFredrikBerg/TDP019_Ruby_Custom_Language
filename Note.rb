class Note

  def initialize(length, tone, octave)

    @length = Rational(1,length)
    @tone = tone
    @octave = 0 + octave
    
  end

  def write
    if @length.denominator != 1
      print @length.denominator.to_s
    end
    print @tone.to_s
    if @octave != 0
      print @octave.to_s
    end
    print " "
  end
  
end

note = Note.new(2,'b',-1)
note2 = Note.new(1,'b', 0)

note.write
note2.write
