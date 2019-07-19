module PrySingular
  Options = Struct.new(:only, :except) {
    def initialize(**options)
      super(Array(options[:only]), Array(options[:except]))
    end

    def remove_methods_other_than_only(methods)
      methods & only
    end

    def remove_except_methods(methods)
      methods - except
    end
  }
end
