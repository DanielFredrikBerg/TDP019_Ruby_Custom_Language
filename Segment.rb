require './Motif.rb'

class Segment

  def initialize(*args)
    @motifs = []
    if args
      args.each {|motif| @motifs << motif }
    end
  end

  def add(*motifs)
    motifs.each do |motif|
      if motif.class != Motif and motif.class != Repeat and motif.class != IfNode
        raise TypeError.new "Trying to add a non-Motif class: #{motif.class} to a Segment"
      else
        @motifs << motif
      end
    end
  end

  def seval
    s = ""
    @motifs.each { |motif| s << motif.seval }
    s
  end
  
  def write
    @motifs.each { |motif| motif.write }
  end

end
