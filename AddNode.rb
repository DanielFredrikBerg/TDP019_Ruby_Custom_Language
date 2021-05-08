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
