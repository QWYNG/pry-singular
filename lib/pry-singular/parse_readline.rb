require "pry"

module PrySingular
  module Slop
    def parse_singular_method_command(items)
      method, args = items.split(" ", 2)
      method + " " + args.delete(" ")
    end
  end
end
