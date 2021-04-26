class ExecutionList < Array

  def initialize
    super
  end

  def seval
    self.each do |execution|
      execution.seval
    end
  end

end
