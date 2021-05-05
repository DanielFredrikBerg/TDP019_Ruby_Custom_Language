class Stack < Array

  def initialize 
    self << Hash.new

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
    false
  end

  def check(name)
    for hash in self.reverse
      if hash.has_key? name
        return true
      end
    end
    false
  end
  
  def append(key, object) # add works only for Segment class
    self.look_up(key).add(object)
  end

  def add(key, object)
    self[-1][key] = object
  end


  
end
