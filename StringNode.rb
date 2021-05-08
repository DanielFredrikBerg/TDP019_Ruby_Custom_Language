class StringNode

  def initialize( string )
    @value = string.gsub(/[']/, '')
  end

  def seval
    @value
  end

end
