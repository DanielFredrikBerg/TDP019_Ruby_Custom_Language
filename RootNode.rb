class RootNode < Array

  def initialize
    super
  end

  def seval
    s = ""
    self.each do |node|
      if node.class == String #in structure, strings are passed in to root_node, these are keys to each segment
        #puts $stack.look_up(node).class
        s += $stack.look_up( node ).seval
      else
        node.seval
      end
    end
    s
  end

  

end
