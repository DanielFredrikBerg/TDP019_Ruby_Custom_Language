class RootNode < Array

  def initialize
    super
  end

  def seval
    self.each do |node|
      node.seval
    end
  end

  

end
