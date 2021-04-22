class NoteIdToken

  def initialize(note)
    @length, @tone, @octave = note.match( /(^[\d]?) ([a-g][#|b]?) ([+|-]\d) / ).captures
    puts [@length, @tone, @octave]
  end

  def seval
    if not @octave
      [@length, @tone, 0]
    elsif not @length
      [4, @tone, @octave]
    elsif not @length and not @octave
      [4, @tone, 0]
    end
  end
      
end
