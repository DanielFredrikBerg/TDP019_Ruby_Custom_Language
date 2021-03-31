# coding: iso-8859-1
require './rdparse'
require './Note'

class Rules
  attr_accessor :file

  def initialize
    @rule_parser = Parser.new("rules") do
      
      ## Tokens utgör Lexern
      token(/\s+/)
      token(/[+|-]/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      #token(/[a-g][b]? | [z]/) {|m| m.to_s }
      token(/[write]+/) { |m| m.to_s }
      token(/./) { |m| m.to_s }

      # token(/([1-3]?[0-9])([A-Ga-g])([+|-]?[0-9])/) {|m| m}
      
      
      
      # Parsern ansvarar för att skapa objekten => AST
      start :function do 
        match( 'write', :note ) { |_,n| n.write }
        match( :note )
      end
      
      # rule :allocation do
      #   match( String, '=', 
      # end
      
      # rule :scale do
      #   match( : )
      #   match( :note )
      # end

      rule :note do 
        match( :length, :tone, :octave ) { 
          |length, tone, octave| Note.new(length, tone, octave) 
        }
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
  
  def done(str)
    ["quit","exit","bye",""].include?(str.chomp)
  end
  
  def interactive_mode
    print "[i-mode] "
    @rule_parser.logger.level = Logger::WARN
    str = gets
    if done(str) then
      puts "Bye."
    else
      puts "#{@rule_parser.parse str}"
      interactive_mode
    end
  end

  def compile_and_run(file)
    run = File.read(file)
    @rule_parser.logger.level = Logger::DEBUG
    puts "=> #{ @rule_parser.parse run } "
  end

  def run_code(code)
    @rule_parser.logger.level = Logger::DEBUG
    puts "=> #{ @rule_parser.parse code } "
  end

  def log(state = true)
    if state
      @rule_parser.logger.level = Logger::DEBUG
    else
      @rule_parser.logger.level = Logger::WARN
    end
  end
end

