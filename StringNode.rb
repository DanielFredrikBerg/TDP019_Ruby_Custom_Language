class StringNode

  attr_accessor :value
  def initialize( string )
    @value = string.gsub(/[']/, '')
  end

  def seval
    @value
  end

end
