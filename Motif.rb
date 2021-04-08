require './Note.rb'

class Motif

  def initialize(*args)
    @notes = []
    if args
      puts "THESE ARE ARGS: #{args}"
      args.each {|note| @notes << note }
    end
  end

  def add(*notes)
    notes.each do |note|
      if note.class != Note
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
