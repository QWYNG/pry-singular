require 'pry'

module PrySingular
  class Pry::Slop
    def parse_singular_method_command(items)
      method, args = items.split(" ", 2)
      method + ' ' + args.gsub(' ', '')
    end
  end
end
