module PrySingular
  class << self
    def adapt_option(methods)
      if @options.only.any?
        @options.adapt_only(methods)
      else
        @options.adapt_except(methods)
      end
    end
  end

  class Options
    attr_reader :only, :except
    def initialize(**options)
      @only   = Array(options[:only])
      @except = Array(options[:except])
    end

    def adapt_only(methods)
      methods & @only
    end

    def adapt_except(methods)
      methods - @except
    end
  end
end
