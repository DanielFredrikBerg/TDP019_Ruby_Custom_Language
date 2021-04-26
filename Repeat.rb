class Repeat

  def initialize(iterations, loop_list) 
    @iterations = iterations.seval
    @loop_list = loop_list
  end
  
  def seval
    @iterations.each do
      @loop_list.each do |statement|
        statement.seval
      end
    end
  end
  
end



