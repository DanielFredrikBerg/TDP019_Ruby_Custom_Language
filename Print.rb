class Print
  def initialize(obj)
    @obj = obj
  end

  def p
    @obj.seval
  end
end
