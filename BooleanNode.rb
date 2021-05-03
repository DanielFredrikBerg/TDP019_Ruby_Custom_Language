class BooleanNode

  def initialize(bool)
    if bool == true
      @bool = true
    elsif bool == false
      @bool = false
    else
      raise Exception.new "Not Valid Boolean Exception"
    end
  end


  def seval
    @bool
  end

end
