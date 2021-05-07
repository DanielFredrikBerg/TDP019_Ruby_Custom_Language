# coding: utf-8
require_relative './Classes'

class Rules
  attr_accessor :file


  def initialize

    # puts "INTILIZING..."

    $stack = Stack.new
    @@root_node = RootNode.new

    @rule_parser = Parser.new("rules") do

      ## Tokens utgör Lexern
      token(/\s+/) #{|m| m.to_s }
      token(/plus/) {|_| AdditionToken.new }
      token(/divided by/) {|_| DivisionToken.new }
      token(/times/) {|_| MultiplicationToken.new }
      token(/minus/) { |_| SubtractionToken.new }
      token(/true/) { |_| TrueToken.new }
      token(/false/) { |_| FalseToken.new }
      token(/if/) {|_| IfToken.new }
      token(/for/) {|_| ForToken.new }
      token(/repeat/) {|_| RepeatToken.new }
      token(/and/) {|_| AndToken.new }
      token(/equals/) {|_| EqualsToken.new }
      token(/or/) {|_| OrToken.new }
      token(/is less than/) {|_| LesserToken.new}
      token(/is more than/) {|_| GreaterToken.new}
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
        match('structure', '{', :segments, '}')  
      end

      rule :segments do
        match(:segments, ',', :var) {|segments, _, segment| @@root_node << segment ; segments} 
        match(:var) {|segment| @@root_node << segment; segment }
      end
      
      rule :segment_block do
        match('segments', '{', :segment_variable_assignments, '}')
      end

      rule :segment_variable_assignments do
        match(:segment_variable_assignments, :segment_variable_assignment)
        match(:segment_variable_assignment)
      end

      rule :segment_variable_assignment do
        match(:segment_variable_assignment, ',', :var) {|segment, _, motif| @@root_node << AddNode.new(segment, motif); segment} #TODO
        match(:var, '=', :var) {|name, _, motif| @@root_node << VarAssNode.new(name, motif); name }
        match(:var, '=', :loop) {|name, _, loop| @@root_node << VarAssNode.new(name, loop); name } 
      end
      
      
      rule :motif_block do
        match('motifs', '{', :motif_statements, '}') 
      end
      
      rule :motif_statements do
        match(:motif_statements, :motif_statement)
        match(:motif_statement)
      end
      
      
      rule :motif_statement do
        match(:var, '=', :if) do |name,_,if_stmt| 
          if if_stmt.evaluate == true
            @@root_node << VarAssNode.new(name, if_stmt) 
          else
            @@root_node << LookUpNode.new(name)
          end
        end
        match(:var, '=', :motif) {|name, _, motif| @@root_node << VarAssNode.new(name, motif); name } 
        
        match(:var, '=', :loop) {|name, _, loop| @@root_node << VarAssNode.new(name, loop); name } 
        match(:var, '=', :expression) { |name, _, expression|  @@root_node << VarAssNode.new(name, expression); name } 
        
        match(:if) { |if_statement| @@root_node << if_statement }
        match(:for_loop) { |for_loop| @@root_node << for_loop }
        match(:loop)
        match(:if_var)
      end
      
## TODO ########################################################################################
      rule :if do 
        match(IfToken, :expression, :comparator, :expression, '[', :statements, ']') do
          |_,lhs,comparator,rhs,_,statements,_|
          IfNode.new(lhs, comparator, rhs, statements)
        end
        match(IfToken, :boolean, :comparator, :boolean, '[', :statements, ']') do
          |_,lhs,comparator,rhs,_,statements,_|
          IfNode.new(lhs, comparator, rhs, statements)
        end
      end

      rule :comparator do
        match(EqualsToken) { |e| StringNode.new(e.s)  }
        match(OrToken) { |o| StringNode.new(o.s)  }
        match(AndToken) { |a| StringNode.new(a.s)  }
        match(LesserToken) { |l| StringNode.new(l.s) }
        match(GreaterToken) { |g| StringNode.new(g.s) }
      end

      rule :boolean do
        match(TrueToken) { |t| BooleanNode.new(t.b)  }
        match(FalseToken) { |t| BooleanNode.new(t.b)  }
      end

      
      rule :for_loop do
        match(ForToken, :expression, '[', :statements, ']') do |_,expression,_,statements,_|
          ForNode.new(expression, statements) 
        end
      end
      
      # $stack.push_frame;  $stack.add(name, loop); $stack.pop_frame } 
      
## TODO ########################################################################################

      rule :loop do 
        match(RepeatToken, :expression, '[', :statements, ']' ) {|_,expr,_,statements,_| Repeat.new(expr, statements) }
        match(RepeatToken, :var, '[', :statements, ']' ) {|_,var,_,statements,_| Repeat.new(var, statements) }
      end

      rule :statements do
        match( :statements, :statement ) {|statements, statement| statements << statement }
        match( :statement ) {|s|  [s] }
      end

      rule :statement do
        match(:var, '=', :motif) {|name, _, motif| x = VarAssNode.new(name, motif); x } 
        match(:var, '=', :expression) { |name, _, expression| VarAssNode.new(name, expression)  }
        match(:motif) {|n| n} 
      end      

      rule :var do
        match(/[A-Z]/) {|m| m}
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
        match( :note, '.', :method, '(', :expression, ')' ) {|note, _, method, _, expression, _| eval "note.#{method}(expression)" } 
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
        # MORE FLESH
      end

      rule :expression do
        match(:expression, AdditionToken, :term) {|a,_,b| Addition.new(a,b) }
        match(:expression, SubtractionToken, :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term, AdditionToken, :term) {|a,_,b| Addition.new(a,b) }
        match(:term, SubtractionToken, :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term)
      end

      rule :term do
        match(:factor, MultiplicationToken, :factor) {|a,_,b| Multiplication.new(a,b) }
        match(:factor, DivisionToken, :factor) {|a,_,b| Division.new(a,b) }
        match(:factor)
      end

      rule :factor do
        match('(',:expression,')') {|_,expression,_| expression }
        match( :var ) {|var| @@root_node << LookUpNode.new(var); var } 
        match(Integer) { |i| IntegerNode.new(i) }
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
      x = root_node.seval
      #puts "STACK: \n #{$stack} \n -------------------------------"
      #puts "ROOT NODE: \n #{root_node} \n -------------------------"
      puts x
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
