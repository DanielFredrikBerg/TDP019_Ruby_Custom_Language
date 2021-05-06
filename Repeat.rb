# coding: iso-8859-1
#require './rules'

class Repeat

  def initialize(iterations, loop_list) 
    @iterations = iterations
    @loop_list = loop_list
  end
  
  def seval
    s = ""
    if @iterations.class == IntegerNode
      miterations = @iterations.seval
    elsif @iterations.class == String
      #Om @iterations visar sig vara en sträng - kolla upp den.
      miterations = $stack.look_up(@iterations).seval
    else 
      puts @iterations
    end
    (1..miterations).each do
      @loop_list.each do |statement|
        if statement.class == Motif
          s += statement.seval
        else
          statement.seval
        end
      end
    end
    s

  end
  
end



