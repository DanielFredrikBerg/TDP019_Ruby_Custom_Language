class ComparatorNode
  def initialize(lhs, comparator, rhs)
    @comparator = comparator
    @lhs = lhs
    @rhs = rhs
  end


  def seval
    case @comparator.seval
    when 'equals'
      return @lhs.seval == @rhs.seval
    when '<'
      return @lhs.seval  < @rhs.seval 
    when '>'
      return @lhs.seval  > @rhs.seval 
    when '<='
      return @lhs.seval  <= @rhs.seval 
    when '>='
      return @lhs.seval  >= @rhs.seval 
    else nil
    end
  end

end
