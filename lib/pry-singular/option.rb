module PrySingular
  Options = Struct.new(:only, :except) {
    def initialize(**options)
      super(Array(options[:only]), Array(options[:except]))
    end

    def adapt_only(methods)
      methods & only
    end

    def adapt_except(methods)
      methods - except
    end
  }
end
