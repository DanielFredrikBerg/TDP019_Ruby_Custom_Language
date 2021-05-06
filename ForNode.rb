#require './rules'

class ForNode

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
    #puts @iterations
  end
  
  def seval
    $stack.push_frame
    (1..@iterations).each do |i|
      for statement in @loop_list
        statement.seval
      end
    end
    $stack.pop_frame
  end
  
end



