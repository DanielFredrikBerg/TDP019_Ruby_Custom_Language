class LookUpNode
  
  def initialize(var_name)
    @var_name = var_name
  end

  def seval
    $stack.look_up(@var_name)
  end

end

