class Stack < Array

  def initialize 
    self << Hash.new

  end

  def push_frame 
    self << Hash.new
  end

  def pop_frame
    lower_frame = self[-2].keys
    upper_frame = self[-1].keys
    common_keys = lower_frame.intersection(upper_frame)

    for key in common_keys
      self[-2][key] = self[-1][key]
    end
    
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
