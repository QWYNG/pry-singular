require_relative "test_helper"

class PrySingularTest < Minitest::Test
  class TestClass1
    class << self
      def class1method ;end
    end
  end

  class TestClass2
    class << self
      def class2method ;end
    end
  end

  class TestClassWithMultipleMethods
    class << self
      def method_one;end
      def method_two;end
    end
  end

  def setup
    PrySingular.set_class(TestClass1, TestClass2)
  end

  def test_set_class_method_to_pry
    assert_includes(Pry::Commands.list_commands, "class1method")
    assert_includes(Pry::Commands.list_commands, "class2method")
  end

  def test_avoid_setting_ancestors_class_methods
    refute_includes(Pry::Commands.list_commands, "class")
    refute_includes(Pry::Commands.list_commands, "new")
  end

  def test_import_the_specific_methods
    PrySingular.set_class TestClassWithMultipleMethods, only: [:method_one]
    assert_includes(Pry::Commands.list_commands, "method_one")
    refute_includes(Pry::Commands.list_commands, "method_two")
  end
end
