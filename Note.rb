class Note
  #TODO: map semitones for different scales somehow.

  attr_accessor :halfstep
  
  def initialize(length, tone, semitone = '',octave)
    
    @length = Rational(1,length)
    @tone = tone
    @semitone = semitone
    @octave = 0 + octave
    
    @halfstep = octave_to_halfstep(@octave) + tone_to_halfstep(@tone) + semitone_to_halfstep(@semitone)
    
  end

  def octave_to_halfstep(octave)
    12 * octave
  end
  
  def tone_to_halfstep(tone)
    t2h = {'c' => 0,
           'd' => 2,
           'e' => 4,
           'f' => 5,
           'g' => 7,
           'a' => 9,
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
    print @tone.to_s
    if @semitone
      print @semitone.to_s
    end
    if @octave > 0
      print '+'
    end
    if @octave != 0
      print @octave.to_s
    end
    print " "
  end
 
  def transposed(step = 1, halfsteps = 0)
    #Will return a note transposed the given number of steps.
    i = step
    tone = @tone
    loop do     
      if tone == 'g'
        tone = 'a'
      else
        tone = tone.next
      end
      i -= 1
      if i == 0
        break
      end
    end
    Note.new(@length.denominator, tone, @octave)
  end
  
end

note = Note.new(2,'b','#',-1)
note2 = Note.new(1,'b', 0)
note3 = Note.new(2,'b',+1)
note4 = Note.new(1,'g',-2)

note.write
note2.write
note3.write
note3.transposed.write
note4.write
note4.transposed(2).write

puts ""

puts note.halfstep
puts note2.halfstep
puts note3.halfstep
puts note4.halfstep

puts ""
