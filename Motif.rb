require './Note.rb'

class Motif

  def initialize
    @notes = []
  end

  def add(note)
    if note.class != Note
      raise TypeError.new "Trying to add a non-Note to Motif"
    else
      @notes << note
    end
  end
  
end
