#require './rules'

class ForNode

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
    $stack.push_frame
  end
  
  def seval
    (1..@iterations).each do
      @loop_list.each do |statement|
        statement.seval
      end
    end
    $stack.pop_frame

  end
  
end



