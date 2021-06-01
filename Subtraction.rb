require './MathNode'
class Subtraction < MathNode

  def initialize(a,b)
    @value = a.seval - b.seval
  end

  def seval
    @value
  end
  
end
