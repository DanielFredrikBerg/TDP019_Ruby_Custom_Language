# Tokens used in parser: rules.rb

# ARITHMETIC TOKENS ##############################################
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

class TrueToken
  attr_reader :b
  def initialize
    @b = true
  end
end

class FalseToken
  attr_reader :b
  def initialize
    @b = false
  end
end

class LesserToken
  attr_reader :s
  def initialize
    @s = 'is less than'
  end
end

class GreaterToken
  attr_reader :s
  def initialize
    @s = 'is more than'
  end
end

# FUNCTION TOKENS ##################################################
class ForToken
end

class IfToken
end

class RepeatToken
end

