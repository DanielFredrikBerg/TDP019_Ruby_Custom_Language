#require './rules'

class Repeat

  def initialize(iterations, loop_list, stack) 
    @iterations = iterations.seval
    @loop_list = loop_list
    @stack = stack
  end
  
  def seval
    @stack.push_frame

    (1..@iterations).each do
      @loop_list.each do |statement|
        statement.seval
      end
    end

    @stack.pop_frame
  end
  
end



