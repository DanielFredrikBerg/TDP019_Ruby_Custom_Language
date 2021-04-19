# coding: iso-8859-1
class Silence

  def initialize(length)
    @length = Rational(1, length.seval)
  end

  # OSäker på om denna ska vara här?
  def seval
    if @length.denominator != 4
      @length.denominator.to_s + "z"
    else
      "z"
    end
  end

  def write
    if @length.denominator != 4
      print @length.denominator.to_s
    end
    print "z "
  end
  
end
