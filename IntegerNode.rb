class IntegerNode
  attr_accessor :value
  def initialize(integer)
    @value = integer
    self
  end

  def seval
    @value
  end
end
