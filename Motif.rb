
require './Silence.rb'

class Motif

  attr_accessor :notes

  def initialize(*args)
    @notes = []
    if args
      args.each {|note| @notes << note }
    end
  end

  def add(*notes)
    notes.each do |note|
      if note.class != Note and note.class != Silence
        raise TypeError.new "Trying to add a non-Note: #{note.class} to Motif"
      else
        @notes << note
      end
    end
  end

  def seval
    s = ""
    @notes.each do |note|
      s << note.seval
    end
    s
  end
  
  def to_s
    s = ""
    @notes.each do |note|
      s += note.seval
    end #This line supresses the each-method from returning 'self', causing it to be written in the terminal. 
    s
  end

end
