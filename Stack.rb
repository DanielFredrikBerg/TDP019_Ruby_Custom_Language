class Stack < Array

  def initialize 
    self << Hash.new
    @bool = false
  end

  def push_frame 
    self << Hash.new
  end

  def pop_frame
    self.pop;nil
  end

  def look_up(name)
    for hash in self.reverse
      if hash.has_key? name
        return hash[ name ]
      end
    end
    @bool
  end

  def check(name)
    for hash in self.reverse
      if hash.has_key? name
        @bool = true
      end
    end
    @bool = false
  end
  

  def add(key, object)
    self[-1][key] = object
  end


  
end
