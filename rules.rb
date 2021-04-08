# coding: iso-8859-1
require './rdparse'
require './Note'
require './Silence'
require './Motif'

class Rules
  attr_accessor :file

  def initialize
    @rule_parser = Parser.new("rules") do
      
      ## Tokens utgör Lexern
      token(/^\s+/) # {|m| m.to_s }
      token(/^[+|-]\d/) {|m| m.to_s }
      token(/^\d+/) {|m| m.to_i }
      token(/^[a-g][#|b]?/) {|m| m.to_s }
      token( /^[a-zA-Z]+/ ) { |m| m.to_s }
      token(/^./) { |m| m.to_s }
      
      
      # Parsern ansvarar för att skapa objekten => AST

      
      start :program do
        match( :function )
        match( :variable_assignment )
      end
      
      rule :variable_assignment do
        match( :variable_name, "=", :type ) do |id,_,type|
          
        end
      end

      rule :variable_name do
        match( /^[a-zA-Z]/ ) { |var_name| var_name.to_s }
      end

      rule :function do
        match( "write", :type ) { |_,m| m.write }     
        match( :type )
      end

      rule :type do
        match( :motif )
        match( :silence )
        match( :note )
      end

      #TODO fix motif matches. Variable_assignment
      rule :motif do
        match( :notes ) { |notes| Motif.new(notes) }
      end

      rule :notes do
        match( :note )
        match( :notes, :note ) 
      end

      rule :note do 
        match( :tone ) { |tone| Note.new( 4, tone, 0 ) }
        match( :length, :tone, :octave ) do
          |length, tone, octave| Note.new( length, tone, octave ) 
        end
      end

      rule :silence do
        match( :length, /[z]/ ) { |length,_| Silence.new( length ) }
        match( /z/ ) {|_| Silence.new(1) }
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
    @rule_parser.logger.level = Logger::DEBUG
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
    @rule_parser.logger.level = Logger::DEBUG
    puts "#{ @rule_parser.parse run } "
  end

  def run_code(code)
    @rule_parser.logger.level = Logger::WARN
    puts "#{ @rule_parser.parse code }"
  end

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
end
