# coding: iso-8859-1
require './rdparse'
require './Note'

class Rules
  attr_accessor :file

  def initialize
    @rule_parser = Parser.new("rules") do
      
      ## Tokens utgör Lexern
      token(/\s+/)
      token(/[+|-]\d/) {|m| m.to_s }
      token(/\d+/) {|m| m.to_i }
      token(/[a-g][#|b]?/) {|m| m.to_s }
      token( /[a-zA-Z]+/ ) { |m| m.to_s }
      token(/./) { |m| m.to_s }
      
      
      # Parsern ansvarar för att skapa objekten => AST

      
      # start :song do 
      #   match( "write", :note ) { |_,n| n.write }
      # end
      
      # rule :allocation do
      #   match( String, '=', 
      # end
      
      # rule :scale do
      #   match( : )
      #   match( :note )
      # end

      start :function do
        match( "write", :note ) { |_,n| n.write }
        match( :note )
      end

      rule :note do 
        match( :tone ) { |tone| Note.new(4, tone, 0) }
        match( :length, :tone, :octave ) do
          |length, tone, octave| Note.new(length, tone, octave) 
        end
      end

      

      rule :length do
        match( Integer )
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

