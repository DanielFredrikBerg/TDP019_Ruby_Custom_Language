require './Segment.rb'

class Structure

  def initialize(*args)
    @segments = []
    if args
      args.each {|segment| @segments << segment }
    end
  end

  def add(*segments)
    segments.each do |segment|
      if segment.class != Segment
        raise TypeError.new "Trying to add a non-Segment to a Structure"
      else
        @segments << segment
      end
    end
  end

  def seval
    @segments.each { |segment| segment.seval }
  end; nil
  
  def write
    @segments.each { |segment| segment.write }
  end

end
