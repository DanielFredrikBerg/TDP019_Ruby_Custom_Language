require './IntegerNode'

class Note
  #TODO: map semitones for different scales somehow.
  
  def initialize(length, tone, octave)
    #puts "#{length}, #{tone}, #{octave}"
    @scale =
      ['c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b' ]

    @length = Rational(1, length)
    
    @halfstep = octave_to_halfstep(octave) + tone_to_halfstep(tone)
    
  end

  #Returns which octave a tone(halfstep) is in.
  def octave(halfstep = @halfstep)
    halfstep / 12
  end

  #Returns the name of a tone(halfstep).
  def tone(halfstep = @halfstep)
    @scale[halfstep % 12]
  end

  #Returns the halfstep-value of c in a given octave.
  def octave_to_halfstep(octave)
    12 * octave
  end


  #Given a tone (expressed in symbols), will  return a halfstep integer representation. 
  def tone_to_halfstep(tone)
    t2h = {
      'cb'=>-1,
      'c'=>0,
      'c#'=>1,
      'db'=>1,
      'd'=>2,
      'd#'=>3,
      'eb'=>3,
      'e'=>4,
      'e#'=>5,
      'fb'=>4,
      'f'=>5,
      'f#'=>6,
      'gb'=>6,
      'g'=>7,
      'g#'=>8,
      'ab'=>8,
      'a'=>9,
      'a#'=>10,
      'bb'=>10,
      'b'=>11,
      'b#'=>12
    }

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

  #Will print the Note in a human readable form
  def seval
    s = ""
    if @length.denominator != 4
      s += @length.denominator.to_s
    end
    s += self.tone
    if self.octave > 0
      s +=  '+'
    end
    if self.octave != 0
      s += self.octave.to_s
    end
    s +=  " "
    s
  end

  #Will return a note transposed the given number of halfsteps.
  def transposed(halfsteps = 1)
    length = @length.denominator
    tone = self.tone(@halfstep + halfsteps.seval)
    octave = self.octave(@halfstep + halfsteps.seval)
    Note.new(length, tone, octave)
  end
  
end
