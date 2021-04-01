class Silence

  def initialize(length)
    @length = Rational(1, length)
  end

  def write
    if @length.denominator != 4
      print @length.denominator.to_s
    end
    print "z "
  end
  
end
