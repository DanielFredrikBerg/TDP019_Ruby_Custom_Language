class VariableList < Hash

  def initialize
    super
  end

  def add(name, object)
    self[ name.seval ] = object
  end

  def find(variable)
    if self[ variable.seval ] != nil
      self[ variable.seval ]
    else
      false
    end
  end

  # Helper function
  def mk_ref(name, existing_variable)
    self[ name.seval ] = self[ existing_variable.seval ]   
  end

  

end
