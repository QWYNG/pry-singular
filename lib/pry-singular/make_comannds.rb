require "pry-singular/slop"
require "pry-singular/option"
require "pry"

module PrySingular
  class << self
    def make_commands(*klasses, **options)
      options = Options.new(options)
      klasses.each do |klass|
        create_singular_method_commands(klass, options)
      end
    end

    private

    def create_singular_method_commands(klass, options)
      filtered_singular_methods = filter_methods_by_option(klass.singleton_methods, options)

      filtered_singular_methods.each do |singular_method|
        singular_method_command(singular_method, klass)
      end
    end

    def filter_methods_by_option(methods, options)
      if options.only.any?
        options.adapt_only(methods)
      else
        options.adapt_except(methods)
      end
    end

    def singular_method_command(singular_method, klass)
      import_pry_command do
        command singular_method.to_s, "#{klass}.#{singular_method}" do
          last_cui_command = Readline::HISTORY.to_a.last

          klass.class_eval <<~EOS, __FILE__, __LINE__ + 1
            #{PrySingular::Slop.parse_singular_method_command(last_cui_command)}
          EOS
        end
      end
    end

    def import_pry_command(&block)
      commands = Pry::CommandSet.new(&block)
      Pry.config.commands.import(commands)
    end
  end
end
