# File Containing all the classes in the project.
# May provide easier overview, but can not be used
# in the project.

class Stack < Array
  def initialize 
    self << Hash.new
  end

  def push_frame 
    self << Hash.new
  end

  def pop_frame
    lower_frame = self[-2].keys
    upper_frame = self[-1].keys
    common_keys = lower_frame.intersection(upper_frame)

    for key in common_keys
      self[-2][key] = self[-1][key]
    end
    
    self.pop;nil
  end

  def look_up(name)
    for hash in self.reverse
      if hash.has_key? name
        return hash[ name ]
      end
    end
    false
  end
 
  def add(key, object)
    self[-1][key] = object
  end  
end

class RootNode < Array
  def initialize
    super
  end

  def seval
    s = ""
    self.each do |node|
      #in structure, strings are passed in to root_node, these are keys to each segment.
      if node.class == String
        s += $stack.look_up( node ).seval
      else
        node.seval
      end
    end
    s
  end
end

class LookUpNode
  def initialize(var_name)
    @var_name = var_name
  end

  def seval
    $stack.look_up(@var_name)
  end
end

class IntegerNode
  def initialize(integer)
    @value = integer
  end

  def seval
    @value
  end  
end

class StringNode
  def initialize( string )
    @value = string.gsub(/[']/, '')
  end

  def seval
    @value
  end
end

class Note  
  def initialize(length, tone, octave)  
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

class Silence
  def initialize(length)
    @length = Rational(1, length)
  end

  def seval
    s = ""
    if @length.denominator != 4
      s += @length.denominator.to_s
    end
    s += "z "
    s
  end  
end

class VarAssNode  
  def initialize(key, value)
    @key = key
    @value = value
  end

  def seval
    if @value.class == String
      @value = Segment.new($stack.look_up(@value))
    end   
    $stack.add(@key, @value)
    ""
  end
end

class Motif
  def initialize(*args)
    @notes = []
    if args
      args.each {|note| @notes << note }
    end
  end

  def add(*notes)
    notes.each do |note|
      if note.class != Note and note.class != Silence
        raise TypeError.new "Trying to add a non-Note to Motif"
      else
        @notes << note
      end
    end
  end

  def seval
    s = ""
    @notes.each do |note|
      s += note.seval
    end
    s
  end
end

class Segment
  def initialize(*args)
    @motifs = []
    if args
      args.each {|motif| @motifs << motif }
    end
  end

  def add(*motifs)
    motifs.each do |motif|
      if motif.class != Motif and motif.class != Repeat and motif.class != IfNode
        raise TypeError.new "Trying to add a non-Motif class: #{motif.class} to a Segment"
      else
        @motifs << motif
      end
    end
  end

  def seval
    s = ""
    @motifs.each do |motif|
      if motif != false
        s += motif.seval
      else
        raise TypeError.new "Trying to access a non-existent variable"
      end
    end
    s
  end
end

class AddNode
  def initialize(key, value)
    @key = key
    @value = value
  end

=begin
     Using the given key-value pair, where both key and value in actuality 
     is a key to a value saved in the stack (think of them as addresses to
     where you can find them in the stack), will look up the value in the
     stack and add it to the key in the stack.
=end
  def seval
    ($stack.look_up(@key)).add($stack.look_up(@value))
  end
end

class MathNode
end

class Addition < MathNode
  def initialize(lhs, rhs)
    @value = lhs.seval + rhs.seval
  end

  def seval
    @value
  end
end

class Subtraction < MathNode
  def initialize(a,b)
    @value = a.seval - b.seval
  end

  def seval
    @value
  end  
end

class Multiplication < MathNode
  def initialize(a,b)
    @value = a.seval * b.seval
  end

  def seval
    @value
  end 
end

class Division < MathNode
  def initialize(a,b)
    @value = a.seval / b.seval
  end

  def seval
    @value
  end 
end

class ComparatorNode 
  def initialize(lhs, comparator, rhs)
    @comparator = comparator
    @lhs = lhs
    @rhs = rhs
  end

  def seval
    case @comparator.seval
    when 'equals'
      return @lhs.seval == @rhs.seval
    when 'and'
      return @lhs.seval && @rhs.seval
    when 'or'
      return @lhs.seval || @rhs.seval  
    when 'is less than'
      return @lhs.seval  < @rhs.seval 
    when 'is more than'
      return @lhs.seval  > @rhs.seval 
    else nil
    end
  end
end

class BooleanNode
  def initialize(bool)
    if bool == true or bool == false
      @bool = bool
    else
      raise Exception.new "Not Valid Boolean Exception"
    end
  end

  def seval
    @bool
  end
end

class Repeat
  def initialize(iterations, loop_list) 
    @iterations = iterations
    @loop_list = loop_list 
  end
  
  def seval
    if @iterations.class == IntegerNode || @iterations.class.superclass == MathNode
      @iterations = @iterations.seval
    elsif @iterations.class == String     
      @iterations = $stack.look_up(@iterations).seval
    elsif @iterations.class == Integer
      @iterations = @iterations
    else
      raise TypeError.new "Iterations in Repeat could not be evaluated to an integer"
    end    
    s = ""
    (1..@iterations).each do
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    s
  end 
end

class IfNode
  def initialize(lhs, comp, rhs, statements)
    @comp = ComparatorNode.new(lhs, comp, rhs)
    @statements = statements
  end
  
  def evaluate
    @comp.seval
  end

  def seval
    $stack.push_frame
    if @comp.seval
      s = ""
      @statements.each do |statement|
        s += statement.seval
      end
    end
    $stack.pop_frame
    s
  end
end

class ForNode
  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
  end
  
  def seval    
    s = ""
    $stack.push_frame
    (1..@iterations).each do 
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    $stack.pop_frame
    s
  end
end



