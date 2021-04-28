class Repeat

  def initialize(iterations, loop_list, scope) 
    @iterations = iterations.seval
    @loop_list = loop_list
  end
  
  def seval
    @@Stackframe.add(stack)

    (1..@iterations).each do
      @loop_list.each do |statement|
        statement.seval
      end
    end

    @@Stackfram.pop
  end
  
end



