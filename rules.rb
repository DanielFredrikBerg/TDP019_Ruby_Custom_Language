# coding: iso-8859-1
require_relative './Classes'


class Rules
  attr_accessor :file


  def initialize

    # puts "INTILIZING..."

    @@vars = Hash.new
    @@root_node = RootNode.new
    @@statements = []
    @@global_scope = Array.new

    @rule_parser = Parser.new("rules") do

      ## Tokens utgör Lexern
      token(/\s+/) #{|m| m.to_s }
      token(/dividedby/) {|m| m.to_s }
      #token(/repeat/) { |r| r.to_s }
      token(/[+|-]\d/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      token(/[a-g][#|b]?/) { |m| m.to_s }
      token( /^[a-zA-Z]+/ ) { |m| m.to_s }
      token(/./) { |m| m.to_s }
      
      # Parsern ansvarar för att skapa objekten => AST

      start :song do
        match(:motif_block, :segment_block, :structure_block) do 
          # For some reason, removing this empty block will cause 
          # the parser to spit out the word motifs.
          @@root_node
        end
      end

      rule :structure_block do
        match('structure', '{', :segments, '}')  #{|_,_,segment,_| @@vars[segment].write }
      end

      rule :segments do
        match(:segments, ',', :var) {|segments, _, segment| @@root_node << @@vars[segment] }
        match(:var) {|segment| @@root_node << @@vars[segment]}
      end
      
      rule :segment_block do
        match('segments', '{', :segment_variable_assignments, '}')
      end

      rule :segment_variable_assignments do
        match(:segment_variable_assignments, :segment_variable_assignment)
        match(:segment_variable_assignment)
      end

      rule :segment_variable_assignment do
        match(:segment_variable_assignment, ',', :var) {|segment, _, motif| segment.add(@@vars[motif]); segment}
        match(:var, '=', :var) {|name, _, motif| @@vars[name] = Segment.new(@@vars[motif])}
      end
      
      
      rule :motif_block do
        match('motifs', '{', :motif_variable_assignments, '}') 
      end
      
      rule :motif_variable_assignments do
        match(:motif_variable_assignments, :motif_variable_assignment)
        match(:motif_variable_assignment)
      end
      
      rule :motif_variable_assignment do
        match(:var, '=', :motif) {|name, _, motif| @@vars[name] = motif}
        match(:var, '=', :loop) {|name, _, loop| @@vars[name] = loop}        
      end
      
#TODO fix motif matches. Variable_assignment
      ## TODO ######################################################################################## ALSO put it in :song somehow
      rule :loop do
        match('rpt', :expression, '[', :statements, ']' ) {|_,expr,_,statements,_| Repeat.new(expr, statements) }
      end

      rule :statements do
        match( :statements, :statement ) {|statements, statement| statements << statement }
        match( :statement ) {|s|  [s] }
      end

      rule :statement do
        match(:motif) {|n| n} 
      end

## TODO ########################################################################################
      
      rule :var do
        match(/[A-Z]/) 
      end

      rule :motif do
        match(:notes) {|n|  n}
        match(:note) {|n| Motif.new(n) }
      end

      rule :notes do
        match( :notes, :note ) do |notes, note|
          notes.add(note)
          notes
        end
        match( :note, :note ) { |note1, note2| Motif.new(note1, note2) }
      end

      rule :note do
        match( :note, '.', :method, '(', :expression, ')' ) {|note, _, method, _, expression, _| note.transposed(expression) } #TODO: find a way to call any method
        match( :length, :tone, :octave ) do
          |length, tone, octave| Note.new( length, tone, octave ) 
        end
        match( :length, :tone) {|length, tone| Note.new(length, tone, 0)}
        match( :tone, :octave) {|tone, octave| Note.new(4, tone, octave)}
        match( :tone ) { |tone| Note.new( 4, tone, 0 ) }
        match( :silence )
      end
      
      rule :method do
        match('transposed') {|m| m}
      end

      rule :expression do
        match(:expression, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:expression, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:term, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term)
      end

      rule :term do
        match(:factor, 'times', :factor) {|a,_,b| Multiplication.new(a,b) }
        match(:factor, 'dividedby', :factor) {|a,_,b| Division.new(a,b) }
        match(:factor)
      end

      rule :factor do
        match(Integer) { |i| IntegerNode.new(i) }
        match('(',:expression,')') {|_,expression,_| expression }
        match( :var ) {|var| @@vars[ var ] } 
      end
      
      rule :silence do
        match( :length, /[z]/ ) { |length,_| Silence.new( length ) }
        match( /[z]/ ) { Silence.new(4) }
      end

      rule :length do
        match( Integer ) { |i| i } 
      end

      rule :octave do 
        match( /[+][0-9]/ ) { |i| i.to_i }
        match( /[-][0-9]/ ) { |i| i.to_i }
      end

      rule :tone do
        match( /[a-g][#|b]?/ ) { |t| t }
      end

    end

    
  end
  
  def done(str)
    ["quit","exit","bye",""].include?(str.chomp)
  end
  
  def interactive_mode
    print "[i-mode] "
    @rule_parser.logger.level = Logger::DEBUG #DEBUG
    str = gets
    if done(str) then
      puts "Bye."
    else
      puts "#{@rule_parser.parse str}"
      interactive_mode
    end
  end

  def test(str)
    @rule_parser.logger.level = Logger::WARN #DEBUG
    if done(str) then
      puts "Bye"
    else
      root_node = @rule_parser.parse str
      #puts root_node.seval
      #puts "=> #{root_node.eval}"

      root_node.seval
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
    @rule_parser.parse code

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::WARN #DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
 
  end
  
end
