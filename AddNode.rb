class AddNode
  def initialize(key, value)
    @key = key
    @value = value
  end

  def seval

    ($stack.look_up(@key)).add($stack.look_up(@value))
    
    # puts $stack
  end

end
