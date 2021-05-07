# Tokens used in parser: rules.rb

# ARITHMETIC TOKENS

class AdditionToken
end

class DivisionToken
end

class MultiplicationToken
end

class SubtractionToken
end

# BOOLEAN TOKENS ##################################################

class AndToken
  attr_reader :s
  def initialize
    @s = 'and'
  end
end

class EqualsToken
  attr_reader :s
  def initialize
    @s = 'equals'
  end
end

class OrToken
  attr_reader :s
  def initialize
    @s = 'or'
  end
end

# FUNCTION TOKENS ##################################################
class ForToken
end

class IfToken
end


