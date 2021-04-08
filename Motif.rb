require './Note.rb'
require './Silence.rb'

class Motif

  def initialize(*args)
    if args
      args.each {|note| @notes << note }
    else
      @notes = []
    end
  end

  def add(*notes)
    notes.each do |note|
      if note.class != Note and note.class != Silence
        raise TypeError.new "Trying to add a non-Note to Motif"
      else
        @notes << note
      end
    end
  end
  
  def write
    @notes.each { |note| note.write }
  end

end
