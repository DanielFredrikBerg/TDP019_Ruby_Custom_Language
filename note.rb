class Note

  def initialize(length, tone, octave)

    @length = Rational(1,length)
    @tone = tone
    @octave = 0 + octave.to_i

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

