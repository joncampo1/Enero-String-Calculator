#
# katayunos 2011.09.24 Donostia
#
# Kata:     StringCalculator, sólo hasta el punto 5 :), reescrita a métodos de 5 sentencias, según sugerencia de @programania ;)
# Language: Ruby 1.9.2
# Author:   @joncampo1 (twitter)

require "test/unit"

class StringCalculator
  
  def list_negatives_add(list_of_negatives, n)
    if n < 0
        list_of_negatives.push(n)
    end
    return list_of_negatives
  end
  
  def list_negatives_get(list)
    list_negatives = []
    list.each do |n|
      nn = n.to_i
      list_negatives = list_negatives_add(list_negatives, nn)
    end
    return list_negatives
  end
  
  def list_of_numbers_parse(numbers)
    delimiter = ","
    if numbers.match(%r!^\/\/!)
      delimiter = numbers[2]
      numbers = numbers[4..numbers.length]
    end
    list_of_numbers = numbers.split(%r!#{delimiter[0]}|\n!)  
  end
 
  def numbers_parse(list)
    list_negatives = list_negatives_get(list)
    unless list_negatives.empty?
      raise ArgumentError, "negatives not allowed: #{list_negatives}"
    end
  end
 
  def list_sum(list)
    sum = 0
    list.each do |n|
      sum += n.to_i
    end
    return sum
  end
 
  def add(numbers)
    return 0 if numbers.empty?
    list_of_numbers = list_of_numbers_parse(numbers)
    numbers_parse(list_of_numbers)   
    sum = list_sum(list_of_numbers)
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
  
