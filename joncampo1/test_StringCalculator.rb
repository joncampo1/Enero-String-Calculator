#
# katayunos 2011.09.24 Donostia
#
# Kata:     StringCalculator, sólo hasta el punto 5 :), reescrita a métodos de 5 sentencias, según sugerencia de @programania ;)
# => , puestos metodos privados y publicos, y refactorizado a otra clase las operaciones en ListOfNumbers
# Language: Ruby 1.9.2
# Author:   @joncampo1 (twitter)

require "test/unit"

class ListOfNumbers
 
  def initialize (line)
    @list_of_numbers = []
    unless line.empty?
      @list_of_numbers = parse(line)
    end
  end
 
  def sum
    sum = 0
    @list_of_numbers.each do |n|
      sum += n
    end
    return sum
  end

  def check_negatives
    list_negatives = @list_of_numbers.find_all{|i| i < 0}
    unless list_negatives.empty?
      raise ArgumentError, "negatives not allowed: #{list_negatives}"
    end
  end
  
  private
  def parse(line)
    delimiter = ","
    if line.match(%r!^\/\/!)
      delimiter = line[2]
      line = line[4..line.length]
    end
    list_of_numbers_strings = line.split(%r!#{delimiter[0]}|\n!)
    @list_of_numbers = list_of_numbers_strings.map {|i| i.to_i()} 
  end    
  
end


class StringCalculator
  
  def add(string_of_numbers)
    listOfNumbers = ListOfNumbers.new string_of_numbers
    listOfNumbers.check_negatives
    return listOfNumbers.sum
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
  
