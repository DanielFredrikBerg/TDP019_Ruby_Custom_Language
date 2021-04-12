require './Note.rb'
require './Silence.rb'

class Motif

  def initialize(*args)
    @notes = []
    if args
      args.each {|note| @notes << note }
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
    puts "notes in motif: "
    @notes.each { |note| note.write }
    puts "\n"
  end

end
