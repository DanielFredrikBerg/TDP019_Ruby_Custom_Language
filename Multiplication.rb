require './MathNode'
class Multiplication < MathNode

  def initialize(a,b)
    @value = a.seval * b.seval
  end

  def seval
    @value
  end
  
end
