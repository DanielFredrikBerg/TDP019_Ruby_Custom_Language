def test_OOnameOO
  output = %x'ruby songic.rb ztests/OOfileOO'
  output = output.split.join(" ")
  puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA: #{output}"
  assert_equal( OOexpectationOO, output + " " )
end


