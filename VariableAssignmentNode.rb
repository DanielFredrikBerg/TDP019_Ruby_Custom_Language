class VarAssNode
  attr_reader :var_value
  def initialize(variable_name, variable_value)
    @var_name = variable_name
    @var_value = variable_value
  end

  def seval
    $stack.add(@var_name, @var_value)
  end

end
