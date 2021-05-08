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
    when 'and'
      return @lhs.seval && @rhs.seval
    when 'or'
      return @lhs.seval || @rhs.seval  
    when 'is less than'
      return @lhs.seval  < @rhs.seval 
    when 'is more than'
      return @lhs.seval  > @rhs.seval 
    else nil
    end
  end

end
