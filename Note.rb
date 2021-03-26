class Note

  def initialize(tone, length = 1, octave = 0)
    @tone = tone
    @length = 1/length
    @octave = 0 + octave
  end  
end
