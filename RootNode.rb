class RootNode < Array

  def initialize
    super
  end

  def seval
    s = ""
    self.each do |node|
      if node.class == String
        s += $stack.look_up( $stack.look_up(node) ).seval
      else
        node.seval
      end
    end
    s
  end

  

end
