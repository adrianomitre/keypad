require File.dirname(__FILE__) + '/test_helper.rb'

class TestKeypad < Test::Unit::TestCase
  def test_words
    words228 = ["aat", "aau", "aav", "abt", "abu", "abv", "act",
                "acu", "acv", "bat", "bau", "bav", "bbt", "bbu",
                "bbv", "bct", "bcu", "bcv", "cat", "cau", "cav",
                "cbt", "cbu", "cbv", "cct", "ccu", "ccv"]
    assert_equal words228, Keypad::words(228)
    dict = %w{ act balloon bat cat dentist }
    valid_words = []
    assert_nothing_raised do
      Keypad::words(228) {|w| valid_words << w if dict.include? w }
    end
    expected = %w{ act bat cat }
    assert_equal expected, valid_words
  end

  def test_number
    assert_equal "228", Keypad::number("cat")
    assert_equal "999", Keypad::number("xyz")
    assert_equal "?", Keypad::number("@")
  end

  def test_letters
    assert_equal ["w", "x", "y", "z"], Keypad::letters(9)
  end

  def test_letters_per_digit
    assert_equal [["a", "b", "c"], ["d", "e", "f"]], Keypad::letters_per_digit(23)
    assert_equal %w(g h i), Keypad::letters_per_digit(4)
    assert_equal %w(j k l), Keypad::letters_per_digit(5)
    assert_equal %w(m n o), Keypad::letters_per_digit(6)
    assert_equal %w(p q r s), Keypad::letters_per_digit(7)
    assert_equal %w(t u v), Keypad::letters_per_digit(8)
    assert_equal %w(w x y z), Keypad::letters_per_digit(9)
    assert_equal [[], [], ["a", "b", "c"], ["d", "e", "f"]], Keypad::letters_per_digit(0, 1, 23)
    assert_equal [[], [], ["a", "b", "c"], ["d", "e", "f"]], Keypad::letters_per_digit(0, 12, 3)
  end
end
