class AddNode
  def initialize(key, value)
    @key = key
    @value = value
  end

  def seval
    $stack.add(@key, @value)
    
  end

end
