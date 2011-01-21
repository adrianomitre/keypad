require 'cartesian'

module Keypad

  VERSION = '1.1.0'

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
  # A block may be given, in which case the explicit pre-computing of the
  # whole cartesian product is avoided.
  #
  #   dict = %w{ act balloon bat cat dentist }
  #   Keypad::words(228) {|w| valid_words << w if dict.include? w } #=> ["act", "bat", "cat"]
  #
  def self.words(number)
    digits = number.to_s.split('')
    iter = digits[1..-1].inject(letters(digits[0])) {|s,k| letters(k).left_product(s) }
    if block_given?
      iter.each {|*elem| yield(elem.join) }
    else
      iter.map {|*elem| elem.join }
    end
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
  def self.number(word)
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
  def self.letters(digit)
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
  def self.letters_per_digit(*numbers)
    result = []
    numbers.each do |number|
      number.to_s.split('').each do |digit|
        result << letters(digit)
      end
    end
    result.size > 1 ? result : result.first
  end

end
