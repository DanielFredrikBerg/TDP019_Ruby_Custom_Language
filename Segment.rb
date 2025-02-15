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
      if motif.class != Motif
        raise TypeError.new "Trying to add a non-Motif to a Segment"
      else
        @motifs << motif
      end
    end
  end
  
  def write
    @motifs.each { |motif| motif.write }
  end

end
