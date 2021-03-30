# coding: iso-8859-1
require './rdparse'
require './Note'

class Rules

  def initialize(file)
    @file = file
    @rule_parser = Parser.new("rules") do
      
      ## Tokens utg�r Lexern
      token(/\s+/)
      token(/[+|-]/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      #token(/[a-g][b]? | [z]/) {|m| m.to_s }
      token(/[write]+/) { |m| m.to_s }
      token(/./) { |m| m.to_s }

      # token(/([1-3]?[0-9])([A-Ga-g])([+|-]?[0-9])/) {|m| m}
      
      
      
      # Parsern ansvarar f�r att skapa objekten => AST
      start :function do 
        match( 'write', :note ) { |_,n| n.write }
        match( :note )
      end
      

      rule :note do 
        match( :length, :tone, :octave ) { |l, t, o| Note.new(l,t,o) }
      end


      rule :length do
        match( Integer )
        match( :tone )
      end
      
      rule :tone do
        match( /[a-g]/ ) { |t| t }
        match( :octave )
      end

      rule :octave do 
        match( '+', Integer ) { |_,o| o }
        match( '-', Integer ) { |_,o| 0-o }
      end

    end

    
  end
  
  def compile_and_run
    run = File.read(@file)
    @rule_parser.logger.level = Logger::WARN
    puts "=> #{ @rule_parser.parse run } "
  end

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
end

