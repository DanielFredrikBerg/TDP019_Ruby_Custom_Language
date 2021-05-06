#require './rules'

class Repeat

  def initialize(iterations, loop_list) 
    @iterations = iterations
    @loop_list = loop_list
  end
  
  def seval

    if @iterations.class == IntegerNode
      @iterations = @iterations.seval
    elsif @iterations.class == String     
      @iterations = $stack.look_up(@iterations).seval
    else
      puts "SoMe KiNd Of FuCkErY In Repeat.rb pertaining to the iterations variable @iterations = #{@iterations}"
    end
    
    
    s = ""
    (1..@iterations).each do
      @loop_list.each do |statement|
        s += statement.seval
      end
    end
    s

  end
  
end



