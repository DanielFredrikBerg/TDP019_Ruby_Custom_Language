# coding: iso-8859-1
require './rdparse'
require './Note'
require './Silence'
require './Motif'

class Rules
  attr_accessor :file


  def initialize
    @@vars = Hash.new
    @rule_parser = Parser.new("rules") do

      ## Tokens utgör Lexern
      token(/\s+/) #{|m| m.to_s }
      token(/[+|-]\d/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      token(/[a-g][#|b]?/) { |m| m.to_s }
      token( /^[a-zA-Z]+/ ) { |m| m.to_s }
      token(/./) { |m| m.to_s }
      
      
      # Parsern ansvarar för att skapa objekten => AST

      start :program do
        #match( "|song|", :statements, "|end song" )
        match( :statements )
      end

      start :statements do
        match( "write", :type ) { |_,m| m.write }
        match( :repetition )

        match( :variable ) { |var| var.write }
        match( :variable_assignment ) 
      end
      
      rule :repetition do
        match( "repeat", :integer, "{", :statements, "}" ) do |_,int,_,statements,_|
          RepeatNode.new(int, statements) 
        end

      end

      rule :variable_assignment do
        match(/[A-Z]+/, '=', :type ) { |name,_,object| @@vars[ name ] = object }
      end

      rule :variable do
        match( /[A-Z]+/ ) { |var| @@vars[ var ] }
      end

      rule :type do
        match(:segment)
        match(:motif)
        match(:note)
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
        match( :tone ) { |tone| Note.new( 4, tone, 0 ) }
        match( :length, :tone, :octave ) do
          |length, tone, octave| Note.new( length, tone, octave ) 
        end
        match( :silence )
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

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
  end
end
