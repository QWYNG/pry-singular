require "pry-singular/slop"
require "pry-singular/option"
require "pry"

module PrySingular
  class << self
    def make_commands(*klasses, **options)
      @options = Options.new(options)
      klasses.each(&method(:create_singular_method_commands))
    end

    private

    def create_singular_method_commands(klass)
      singular_methods = adapt_option(klass.singleton_methods)

      singular_methods.each do |singular_method|
        singular_method_command(klass, singular_method)
      end
    end

    def singular_method_command(klass, singular_method)
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
