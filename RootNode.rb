class RootNode < Array

  def initialize
    super
  end

  def seval
    s = ""
    self.each do |node|
      #in structure, strings are passed in to root_node, these are keys to each segment.
      if node.class == String
        s += $stack.look_up( node ).seval
      else
        node.seval
      end
    end
    s
  end

  

end
