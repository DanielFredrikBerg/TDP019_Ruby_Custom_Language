class VarAssNode
  def initialize(key, value)
    @key = key
    @value = value
  end

  def seval
    if @value.class == String
      #puts "CLASS IS STRING"
      #puts "LOOKUP OF VALUE: #{$stack.look_up(@value).class}"
      #puts "#{Segment.new($stack.look_up(@value))}"
      @value = Segment.new($stack.look_up(@value))
    end   
    $stack.add(@key, @value)
    ""
  end

end
