# coding: iso-8859-1
require './Classes'

class Rules
  attr_accessor :file

  def initialize
    @@objcs = VariableList.new

    @@executions = ExecutionList.new

    @rule_parser = Parser.new("rules") do
      
      ## Tokens utgör Lexern
      token(/\s+/) #{|m| m.to_s }
      token(/'[\w]+'/) {|m| StringNode.new(m) }
      token(/div/) {|m| m.to_s }
      token(/[+|-]\d/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      token(/[a-g][#|b]?/) { |m| m.to_s }
      token( /[a-zA-ZåäöÅÄÖ]+/ ) { |m| m.to_s }
      token(/./) { |m| m.to_s }

      start :song do
        # match(:motif_block, :segment_block, :structure_block) do 
        # for som reason, removing this empty block will cause the parser to spit out the word motifs
        # end
         # { |e| @@executions.seval }
        match(:executions) { |e| @@executions }
      end

      rule :executions do
        match( :executions, :execution ) { |_,es| @@executions << es }
        match( :execution, :execution )
      end

      rule :execution do
      # match( :repeat )
        match( :print )
        # TODO:
        # match( :if ) 
        # match( :while )
        # match( :for )
        match( :variable_assignment )
        match( :expression )
      end

      rule :print do
        match( 'p', :expression ) { |_, object| Print.new(object).p }
        match( 'p', :type ) { |_, object| Print.new(object).p }
        match( 'p', :var ) { |_, name| Print.new( @@objcs.find(name) ).p }
      end

      rule :variable_assignment do
        match( :variable_assignment, :variable_assignment )
        match( :var, '=', :var , ";") { |name, _, existing_var| @@objcs.mk_ref(name, existing_var) }
        match( :var, '=', :expression, ";" ) { |name, _, math| @@objcs.add(name, math) }
        match( :var, '=', :type, ";" ) { |name,_,value| @@objcs.add(name, value) }    
      end
      
      rule :var do
        match(/[A-Z0-9ÅÄÖ]+/) { |name| StringNode.new(name) }
      end
      
      rule :type do
        match( Integer ) { |i| IntegerNode.new(i) }
        match( StringNode ) { |s| s } 
      end
      
      rule :expression do
        match(:expression, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:expression, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term, 'plus', :term) {|a,_,b| Addition.new(a,b) }
        match(:term, 'minus', :term) {|a,_,b| Subtraction.new(a,b) }
        match(:term)
      end

      rule :term do
        match(:term, 'times', :factor) {|a,_,b| Multiplication.new(a,b) }
        match(:term, 'div', :factor) {|a,_,b| Division.new(a,b) }
        match(:factor, 'times', :factor) {|a,_,b| Multiplication.new(a,b) }
        match(:factor, 'div', :factor) {|a,_,b| Division.new(a,b) }
        match(:factor)
      end

      rule :factor do
        match(Integer) { |i| IntegerNode.new(i) } 
        match('(',:expression,')') {|_,expression,_| expression }
#        match(:var)
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
        root_node = @rule_parser.parse str
        puts "#{root_node.seval} "
        interactive_mode
      end
    end

    def test(str)
      @rule_parser.logger.level = Logger::WARN
      if done(str) then
        puts "Bye"
      else
        puts str
        root_node = @rule_parser.parse str
        puts root_node.seval 
        #puts "=> #{root_node.eval}"
        
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
end
