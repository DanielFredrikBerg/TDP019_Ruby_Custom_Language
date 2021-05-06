#require './rules'

class Repeat

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
  end
  
  def seval
    s = ""
    (1..@iterations).each do
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    s

  end
  
end



