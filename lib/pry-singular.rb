require "pry-singular/version"
require "pry-singular/extract_pry_singular_options"
require "pry-singular/parse_readline"
require "pry"

module PrySingular
  class << self
    def make_command(*klasses)
      options = klasses.extract_pry_singular_options!
      normalize_pry_singular_options!(options)
      klasses.each do |klass|
        import_class_command(klass, options)
      end
    end

    private

    def normalize_pry_singular_options!(options)
      options[:only] = Array(options[:only])
      options[:except] = Array(options[:except])
    end

    def import_class_command(klass, options)
      singular_methods = adapt_options_singleton_methods(klass, options)
      import_pry_command do
        singular_methods.each do |klass_method|
          command klass_method.to_s, "#{klass}.#{klass_method}" do
            klass.class_eval <<-EOS, binding, __FILE__, __LINE__ + 1
              #{PrySingular::Slop.parse_singular_method_command(Readline::HISTORY.to_a.last)}


            EOS
          end
        end
      end
    end

    def import_pry_command(&block)
      commands = Pry::CommandSet.new(&block)
      Pry.config.commands.import(commands)
    end

    def adapt_options_singleton_methods(klass, options)
      if options[:only].any?
        return options[:only].select { |method_name| klass.respond_to?(method_name) }
      end

      klass.singleton_methods - options[:except]
    end
  end
end
