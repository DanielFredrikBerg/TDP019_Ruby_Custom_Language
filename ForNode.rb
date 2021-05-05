#require './rules'

class ForNode

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
    #puts @loop_list
  end
  
  def seval
    $stack.push_frame
    (1..@iterations).each do |i|
      break if i == @iterations
      @loop_list.each do |statement|
        statement.seval
      end
    end
    $stack.pop_frame(true)
    ""
  end
  
end



