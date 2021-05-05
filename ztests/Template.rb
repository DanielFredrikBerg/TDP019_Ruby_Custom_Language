
def test_OOnameOO
  output = StringIO.new
  $stdout = output
  output = %x'ruby songic.rb ztests/OOfileOO'
  output = output.split()
  #puts "After split: #{output}" #DEBUG
  output = output.join(" ")
  #puts "After join: #{output}" #DEBUG
  
  assert_equal( OOexpectationOO, output.to_s + " " )
end


