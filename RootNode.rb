class RootNode < Array

  def initialize
    super
  end

  def seval
    s = ""
    self.each do |node|
      s += node.seval
    end
    s
  end

  

end
