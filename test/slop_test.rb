require_relative "test_helper"

class PrySingular::SlopTest < Minitest::Test
  def test_parse_singular_method_command
    command_entered = "create :user, :super, name: 'Thresh'"
    assert_equal("create :user,:super,name:'Thresh'", PrySingular::Slop.parse_singular_method_command(command_entered))
  end
end
