# coding: utf-8
require './Classes'

class Rules
  attr_accessor :file

  def initialize
    @@vars = Hash.new
    @@executions = Array.new

    @rule_parser = Parser.new("rules") do
      
      ## Tokens utgör Lexern
      token(/\s+/) #{|m| m.to_s }
      token(/[+|-]\d/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      token(/[a-g][#|b]?/) { |m| m.to_s }
      token( /[a-zA-ZåäöÅÄÖ]+/ ) { |m| m.to_s }
      token(/./) { |m| m.to_s }

      start :song do
        match(:motif_block, :segment_block, :structure_block) do #for som reason, removing this empty block will cause the parser to spit out the word motifs
        end
        match(:executions)
      end
      
      

      rule :executions do
        match( :executions, :executions )
        match( :repeat )
        match( :print )
        # TODO:
        # match( :if ) 
        # match( :while )
        # match( :for )
        match( :variable_assignment )
        match( :expression )
      end

      rule :variable_assignment do
        match( :variable_assignment, :variable_assignment )
        match( :var, '=', :type ) { |var,_,value| @@vars[ var ] = value }
        match( :var, '=', :expression ) { |name, _, math| @@vars[name] = math }
      end

      rule :print do
        match( "p", /[A-ZÅÄÖ]/ ) { |_,name| @@vars[ name ] }
      end

      rule :type do
        match( Integer ) { |i| IntegerNode.new(i) }
        match( "'", String, "'" ) { |_,s,_| StringNode.new(s) } 
      end

      rule :expression do
        match(:expression, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:expression, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:term, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term)
      end

      rule :term do
        match(:factor, 'times', :factor) {|a,_,b| Multiplication.new(a,b).seval }
        match(:factor, 'divided by', :factor) {|a,_,b| Division.new(a,b) }
        match(:factor)
      end

      rule :factor do
        match(Integer) { |i| IntegerNode.new(i) } 
        match('(',:expression,')') {|_,expression,_| expression }
      end


      rule :structure_block do
        match('structure', '{', :segments, '}') #{|_,_,segment,_| @@vars[segment].write }
      end

      rule :segments do
        match(:segments, ',', :var) {|segments, _, segment| @@vars[segment].write}
        match(:var) {|segment| @@vars[segment].write}
      end
      
      rule :segment_block do
        match('segments', '{', :segment_execution, '}')
      end

      rule :segment_execution do
        match( :segment_execution, :segment_execution )
        match( :executions )
        match( :segment_variable_assignment )
      end

      rule :segment_variable_assignment do
        match(:segment_variable_assignment, :segment_variable_assignment)
        match(:segment_variable_assignment, ',', :var) {|segment, _, motif| segment.add(@@vars[motif])}
        match(:var, '=', :var) {|name, _, motif| @@vars[name] = Segment.new(@@vars[motif])}
      end
      
      rule :motif_block do
        match('motifs', '{', :motif_execution, '}')
        #match('motifs', '{', :motif_variable_assignment, '}')
      end

      rule :motif_execution do
        match( :motif_execution, :motif_execution )
        match( :executions )
        match( :motif_variable_assignment )
      end

      rule :motif_variable_assignment do
        match(:motif_variable_assignment, :motif_variable_assignment) 
        match(:var, '=', :motif) {|name, _, motif| @@vars[name] = motif}
      end   

      rule :var do
        match(/[\wåäöÅÄÖ]+/) { |name| name.to_s }
      end

      rule :motif do
        match(:notes) 
      end

      rule :notes do
        match( :notes, :note ) do |notes, note|
          notes.add(note)
          notes
        end
        match( :note, :note ) { |note1, note2| Motif.new(note1, note2) }
      end

      rule :note do
        match( :note, '.', :method, '(', :expression, ')' ) {|note, _, method, _, expression, _| eval "note.#{method}(expression)" } 
        match( :length, :tone, :octave ) do
          |length, tone, octave| Note.new( length, tone, octave ) 
        end
        match( :length, :tone) {|length, tone| Note.new(length, tone, IntegerNode.new(0))}
        match( :tone, :octave) {|tone, octave| Note.new(IntegerNode.new(4), tone, octave)}
        match( :tone ) { |tone| Note.new( IntegerNode.new(4), tone, IntegerNode.new(0) ) }
        match( :silence )
      end
      
      rule :method do
        match('transposed') {|m| m}
      end

      rule :silence do
        match( :length, /[z]/ ) { |length,_| Silence.new( length ) }
        match( /[z]/ ) { Silence.new(4) }
      end

      rule :length do
        match( Integer ) { |i| IntegerNode.new(i); } 
      end

      rule :octave do 
        match( /[+][0-9]/ ) { |i| IntegerNode.new(i.to_i) }
        match( /[-][0-9]/ ) { |i| IntegerNode.new(i.to_i) }
      end

      rule :tone do
        match( /[a-g][#|b]?/ ) { |t| StringNode.new(t) }
      end

    end

    
  end
  
  def done(str)
    ["quit","exit","bye",""].include?(str.chomp)
  end
  
  def interactive_mode
    print "[i-mode] "
    @rule_parser.logger.level = Logger::WARN #DEBUG
    str = gets
    if done(str) then
      puts "Bye."
    else
      puts "#{@rule_parser.parse str}"
      interactive_mode
    end
  end

  def test(str)
    @rule_parser.logger.level = Logger::WARN
    if done(str) then
      puts "Bye"
    else
      root_node = @rule_parser.parse str
      puts root_node.class
      #puts "=> #{root_node.eval}"
      root_node
    end
  end

  def compile_and_run(file)
    run = File.read(file)
    @rule_parser.logger.level = Logger::WARN #DEBUG
    puts "#{ @rule_parser.parse run } "
  end

  def run_code(code)
    @rule_parser.logger.level = Logger::WARN
    puts "#{ @rule_parser.parse code }"
  end

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::WARN #DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
  
end
