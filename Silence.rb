class Silence

  def initialize(length)
    @length = Rational(1, length)
  end

  def seval
    s = ""
    if @length.denominator != 4
      s += @length.denominator.to_s
    end
    s += "z "
    s
  end
  
end
