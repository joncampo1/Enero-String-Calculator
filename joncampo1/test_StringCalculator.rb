#
# katayunos 2011.09.24 Donostia
#
# Kata:     StringCalculator, sólo hasta el punto 5 :)
# Language: Ruby 1.9.2
# Autor:    joncampo1@gmail.com
#
require "test/unit"

class StringCalculator
 
  def add(numbers)
    return 0 if numbers.empty?
   
    if numbers.match(/^\/\//)
      delimiter = numbers[2]
      numbers = numbers[4..numbers.length]
      list_of_numbers = numbers.split(%r{#{delimiter[0]}})
    else
      list_of_numbers = numbers.split(/,|\n/)  
    end
   
    sum = 0
    list_negatives = []
    list_of_numbers.each do |n|
      nn = n.to_i
      if nn < 0
        list_negatives.push(nn)
      end
      sum += nn
    end
    
    if !list_negatives.empty?
      raise ArgumentError, "negatives not allowed: #{list_negatives}"
    end
    
    return sum
  end

end


class TestStringCalculator < Test::Unit::TestCase
  def setup
    @stringCalculator = StringCalculator.new
  end
  def test_add_empty
    assert_equal 0, @stringCalculator.add("")
  end
  def test_add_1
    assert_equal 1, @stringCalculator.add("1")
  end
  def test_add_1_2
    assert_equal 3, @stringCalculator.add("1,2")
  end
  def test_add_1_2_3
    assert_equal 6, @stringCalculator.add("1,2,3")
  end
  def test_add_new_line
    assert_equal 7, @stringCalculator.add("1\n2,4")
  end
  def test_add_delimiter
    assert_equal 8, @stringCalculator.add("//;\n1;2;5")
  end
  def test_add_delimiter_2
    assert_equal 8, @stringCalculator.add("///\n1/2/5")
  end
  def test_add_negatives
    e = assert_raise (ArgumentError){@stringCalculator.add("///\n-1/-3/5")}
    assert_equal("negatives not allowed: [-1, -3]", e.message)
  end
  def test_add_negatives_2
    e = assert_raise (ArgumentError){@stringCalculator.add("///\n-1/-3/-5/6")}
    assert_equal("negatives not allowed: [-1, -3, -5]", e.message)
  end
end
  
