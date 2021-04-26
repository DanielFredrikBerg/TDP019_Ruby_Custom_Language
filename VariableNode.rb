# VariableNode is a reference placeholder for all different objects.
# When evaluated the object referenced is returned.

class VariableNode
  attr_accessor :name, :object

  def initialize(name)
    @name = name
    @obj = nil
  end

  def seval
    @obj
  end
  

end

