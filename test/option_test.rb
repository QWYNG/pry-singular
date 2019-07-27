require_relative "test_helper"

class PrySingular::OptionsTest < Minitest::Test
  def setup
    @option = PrySingular::Options.new(only: :require_method, except: :not_require_method)
  end

  def test_initialize
    assert_equal([:require_method], @option.only)
    assert_equal([:not_require_method], @option.except)
  end

  def test_adapt_only
    methods = [:require_method, :not_require_method]
    assert_equal([:require_method], @option.adapt_only(methods))
  end

  def test_adapt_except
    methods = [:require_method, :not_require_method]
    assert_equal([:require_method], @option.adapt_except(methods))
  end
end
