class Stack < Array

  def initialize 
    self << Hash.new
    
  end

  def push_frame 
    self << Hash.new
  end

  def pop_frame
    self.pop
  end

  def look_up(name)
    for hash in self.reverse
      if hash.has_key? name
        return hash[ name ]
      end
    end
    return false
  end

  def add(key, object)
    self[-1][key] = object
  end


  
end
