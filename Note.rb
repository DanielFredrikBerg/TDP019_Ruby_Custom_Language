class Note
  #TODO: map semitones for different scales somehow.

  attr_accessor :halfstep
  
  def initialize(length, tone, octave)

    @scale = ['c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b' ]
    
    @length = Rational(1,length)
    
    @halfstep = octave_to_halfstep(octave) + tone_to_halfstep(tone)
    
  end

  def octave(halfstep = @halfstep)
    halfstep / 12
  end

  def tone(halfstep = @halfstep)
    @scale[halfstep % 12]
  end
  
  def octave_to_halfstep(octave)
    12 * octave
  end
  
  def tone_to_halfstep(tone)
    t2h = {'c' => 0,
           'c#' => 1,
           'd' => 2,
           'd#' => 3,
           'e' => 4,
           'f' => 5,
           'f#' => 6,
           'g' => 7,
           'g#' => 8,
           'a' => 9,
           'a#' => 10,
           'b' => 11}
    t2h[tone]    
  end

  def semitone_to_halfstep(semitone='')
    case semitone
    when '#'
      +1
    when 'b'
      -1
    when ''
      0
    end
  end
  
  def write
    #Will print the the Note in a human readable form
    if @length.denominator != 1
      print @length.denominator.to_s
    end
    print self.tone.to_s
    if self.octave > 0
      print '+'
    end
    if self.octave != 0
      print self.octave.to_s
    end
    print " "
  end
 
  def transposed(halfsteps = 1)
    #Will return a note transposed the given number of steps.
      Note.new(@length.denominator, self.tone(@halfstep + halfsteps), self.octave(@halfstep + halfsteps) )
  end
  
end

# note = Note.new(2,'c#',-1)
# note2 = Note.new(1,'b', 0)
# note3 = Note.new(2,'b',+1)
# note4 = Note.new(1,'g',-2)

# note.write
# note2.write
# note3.write
# note3.transposed.write
# note4.write
# note4.transposed.write
# note4.transposed(2).write

# puts ""

# puts note.halfstep
# puts note2.halfstep
# puts note3.halfstep
# puts note4.halfstep

# puts ""
