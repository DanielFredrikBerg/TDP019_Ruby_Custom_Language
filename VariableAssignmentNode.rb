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
