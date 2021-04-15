
class VariableList

  def initialize
    @@variables = {}
    @@functions = {}
  end

  # Helper function
  def find(name, hash)
    hash[var]
  end

end


class VariableNode

  def initialize(variable_name, type)
    @var_name = variable_name
    @type = type
  end
  
end

