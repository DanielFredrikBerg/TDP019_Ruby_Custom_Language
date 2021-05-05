class Stack < Array

  def initialize 
    self << Hash.new
    @bool = false
  end

  def push_frame 
    self << Hash.new
  end

  def pop_frame(bool = false)
    if bool
      #puts self[-1]
      self[-2] = self[-2].merge(self[-1])
      #puts self[-2]['A']
      #puts self[-2]['C']
    end
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
        return true
      end
    end
    false
  end
  
  def to_s
    s = ""
    self.each do |hash|
      hash.each do |pair|
        s += pair[0].to_s
        s += pair[1].to_s
      end
    end
    s
  end

  def add(key, object)
    # if $stack.check(key) != true
    #   #puts "if"
      self[-1][key] = object
    # else
    #   self[0][key] = object
    #   #puts self[0][key].seval
    # end
  end


  
end
