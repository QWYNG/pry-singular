require "pry"

module PrySingular
  module Slop
    def parse_singular_method_command(command)
      method, args = command.split(" ", 2)
      "#{method} #{args.delete(" ")}"
    end

    module_function :parse_singular_method_command
  end
end
