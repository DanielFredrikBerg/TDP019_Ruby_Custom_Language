require './MathNode'
class Division < MathNode

  def initialize(a,b)
    @value = a.seval / b.seval
  end

  def seval
    @value
  end
  
end
