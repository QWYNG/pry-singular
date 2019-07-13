require_relative "test_helper"

class PrySingularTest < Minitest::Test
  class TestClass1
    class << self
      def hello ;end
    end
  end

  class TestClass2
    class << self
      def oha ;end
    end
  end

  def setup
    PrySingular.set_class(TestClass1, TestClass2)
  end

  def test_set_class_method_to_pry
    assert_includes(Pry::Commands.list_commands, "hello")
    assert_includes(Pry::Commands.list_commands, "oha")
  end

  def test_avoid_setting_ancestors_class_methods
    refute_includes(Pry::Commands.list_commands, "class")
    refute_includes(Pry::Commands.list_commands, "new")
  end
end