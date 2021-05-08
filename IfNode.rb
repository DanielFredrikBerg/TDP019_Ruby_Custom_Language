require './ComparatorNode.rb'

class IfNode
  def initialize(lhs, comp, rhs, statements)
    @comp = ComparatorNode.new(lhs, comp, rhs)
    @statements = statements
  end
  
  def evaluate
    @comp.seval
  end

  def seval
    $stack.push_frame
    if @comp.seval
      s = ""
      @statements.each do |statement|
        s += statement.seval
      end
    end
    $stack.pop_frame
    s
  end
  

end
