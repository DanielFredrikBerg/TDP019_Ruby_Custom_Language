require './MathNode'
class Addition < MathNode

  def initialize(lhs, rhs)
    @value = lhs.seval + rhs.seval
  end

  def seval
    @value
  end

end
