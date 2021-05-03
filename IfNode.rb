require './ComparatorNode.rb'


class IfNode
  def initialize(lhs, comp, rhs, statements)
    @comp = ComparatorNode.new(lhs, comp, rhs)
    @statements = statements
    #$stack.push_frame
  end
  
  def evaluate
    @comp.seval
  end

  def seval
    if @comp.seval
      @statements.each do |statements|
        statements.seval
      end      
    end
    
    #$stack.pop_frame
  end
  

end
