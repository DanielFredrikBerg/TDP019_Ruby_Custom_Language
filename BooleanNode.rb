class BooleanNode

  def initialize(bool)
    if bool == true or bool == false
      @bool = bool
    else
      raise Exception.new "Not Valid Boolean Exception"
    end
  end

  def seval
    @bool
  end

end
