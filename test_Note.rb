require 'test/unit'
require './Note'
require './rules'

class TestNote < Test::Unit::TestCase

  @@songic = Rules.new

  def test_note
    assert_equal( "2a3", @@songic.run_code("write 2a+3") ) 
    
    

  end


end
