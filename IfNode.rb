require './ComparatorNode.rb'


class IfNode
  def initialize(left_expression, comparator, right_expression, statements)
    @lhs = left_expression
    @comp = comparator
    @rhs = right_expression
    @statements = statements
  end
  
  def seval
    if ComparatorNode.new(@lhs, @comp, @rhs).seval
      @statements.each do |statements|
        statements.seval
      end
    end
  end
  

end
