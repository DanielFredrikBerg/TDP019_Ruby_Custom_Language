#require './rules'

class ForNode

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
    #puts @iterations
    #puts @loop_list
  end
  
  def seval
    
    s = ""
    $stack.push_frame
    (1..@iterations).each do 
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    $stack.pop_frame
    s
  end
  
end



