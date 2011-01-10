require 'cartesian'

=begin
  == Description

  The Keypad module provides methods to determine
  all sequences of letters associated to a given number
  according to standard phone keypad. The "inverse" function,
  i.e., find the digits corresponding to a certain word,
  is also provided.

  == Author

  Adriano Brito Mitre <adriano.mitre@gmail.com>

  == Ackowledgements

  I was driven to coding this after reading the beggining of
  a post entitled "Google Splash" from Ernest Turro's blog.
  One can read the post [here](http://ernest.turro.cat/blog/2006/08/25/google-splash).

  The Keypad module determine all sequences of letters (not necessarily
  valid words) associated to a given number using according to
  standard phone keypad.

  If a dictionary is available, filtering out invalid words is
  as trivial as
     
     Keypad::words(_number_).select{|word| _dictionary_.includes? word }

  Finally, the converse functionality is also provided.
  The _number_ method finds the sequences of digits associated
  with a given word according to standard phone keypad.

  == References

  Similar systems and more information can be found at
    * [PhoneSpell](http://www.phonespell.org)
    * [DialABC](http://www.dialabc.com)
=end

module Keypad

  VERSION = '1.0.2'

  #--
  # TODO: Find a way of preventing RDoc from linking the words
  # "words" and "number" below to the methods with same name.
  #++
  # Returns all sequences of letters (not necessarily valid words
  # in natural languages) associated with a given number using
  # according to standard phone keypad.
  # Remember to quote numbers beginning with zero,
  # for octal base is otherwise assumed for zero-beginning numbers.
  #
  #   Keypad::words(228) #=> ["aat", "aau", "aav", "abt", "abu", "abv", "act",
  #                           "acu", "acv", "bat", "bau", "bav", "bbt", "bbu",
  #                           "bbv", "bct", "bcu", "bcv", "cat", "cau", "cav",
  #                           "cbt", "cbu", "cbv", "cct", "ccu", "ccv"]
  #
  def Keypad.words(number)
    letter_seq = letters_per_digit(number)
    words = letter_seq.shift
    letter_seq.each do |seq|
      words = Cartesian::joined_product( words, seq )
    end
    words
  end

  #--
  # TODO: Find a way of preventing RDoc from linking the words
  # "number" below to the method with same name.
  #++
  # Returns the number (i.e., the sequences of digits) associated
  # with the given word according to standard phone keypad.
  #
  #   Keypad::number("cat") #=> "228"
  #
  def Keypad.number(word)
    ary = word.downcase.split('').map do |letter|
            case letter
            when 'a'..'c' then 2
            when 'd'..'f' then 3
            when 'g'..'i' then 4
            when 'j'..'l' then 5
            when 'm'..'o' then 6
            when 'p'..'s' then 7
            when 't'..'v' then 8
            when 'w'..'z' then 9
            else '?'
            end
          end
    ary.join
  end

  # Returns the letters associated with a given numerical digit,
  # in lower case.
  #
  #   Keypad::letters(9) #=> ["w", "x", "y", "z"]
  #
  def Keypad.letters(digit)
    case digit.to_i
      when 2 then %w(a b c)
      when 3 then %w(d e f)
      when 4 then %w(g h i)
      when 5 then %w(j k l)
      when 6 then %w(m n o)
      when 7 then %w(p q r s)
      when 8 then %w(t u v)
      when 9 then %w(w x y z)
      else []
    end
  end

  # Returns the letters associated with each given numerical digit.
  #
  #   Keypad::letters_per_digit(2) #=> ["a", "b", "c"]
  #   Keypad::letters_per_digit(23) #=> [["a", "b", "c"], ["d", "e", "f"]]
  #   Keypad::letters_per_digit(0, 12, 3) #=> [[], [], ["a", "b", "c"], ["d", "e", "f"]], 
  #
  def Keypad.letters_per_digit(*numbers)
    result = []
    numbers.each do |number|
      number.to_s.split('').each do |digit|
        result << letters(digit)
      end
    end
    result.size > 1 ? result : result.first
  end

end
