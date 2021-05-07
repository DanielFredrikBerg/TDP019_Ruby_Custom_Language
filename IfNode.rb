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
    $stack.push_frame
    if @comp.seval
      s = ""
      @statements.each do |statement|
        s += statement.seval
      end
    end
    #puts "BEFORE: \n #{$stack} \n -------------------"
    $stack.pop_frame
    #puts "AFTER: #{$stack} \n --------------------"
    s
  end
  

end
