require_relative "test_helper"

class PrySingularTest < Minitest::Test
  class TestClass1
    class << self
      def class1method
      end
    end
  end

  class TestClass2
    class << self
      def class2method
      end
    end
  end

  class TestClassWithOnlyOption
    class << self
      def require_method
      end

      def not_require_method
      end
    end
  end

  class TestClassWithExceptOption
    class << self
      def need_to_exclude_method
      end

      def need_to_include_method1
      end

      def need_to_include_method2
      end
    end
  end

  def test_make_command_method_to_pry
    PrySingular.make_command(TestClass1, TestClass2)
    assert_includes(Pry::Commands.list_commands, "class1method")
    assert_includes(Pry::Commands.list_commands, "class2method")
  end

  def test_avoid_setting_ancestors_class_methods
    PrySingular.make_command(TestClass1, TestClass2)
    refute_includes(Pry::Commands.list_commands, "class")
    refute_includes(Pry::Commands.list_commands, "new")
  end

  def test_import_the_specific_methods
    PrySingular.make_command TestClassWithOnlyOption, only: [:require_method]
    assert_includes(Pry::Commands.list_commands, "require_method")
    refute_includes(Pry::Commands.list_commands, "not_require_method")
  end

  def test_import_methods_expect
    PrySingular.make_command TestClassWithExceptOption, except: [:need_to_exclude_method]
    refute_includes(Pry::Commands.list_commands, "need_to_exclude_method")
    assert_includes(Pry::Commands.list_commands, "need_to_include_method1")
    assert_includes(Pry::Commands.list_commands, "need_to_include_method2")
  end
end
