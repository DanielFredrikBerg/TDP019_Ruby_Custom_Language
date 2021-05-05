#require './rules'

class Repeat

  def initialize(iterations, loop_list) 
    @iterations = iterations
    @loop_list = loop_list
  end
  
  def seval
    s = ""
    miterations = $stack.look_up(@iterations)
    (1..miterations).each do
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    s

  end
  
end



