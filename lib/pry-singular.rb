require "pry-singular/version"
require 'pry'

module PrySingular
  class << self
    def set_class(*klasses)
      import_class_command(klasses)
    end

    private

    def import_class_command(klasses)
      commands = Pry::CommandSet.new do
        klasses.each do |klass|
          klass.public_methods.each do |klass_method|
            command "#{klass_method}", "#{klass}.#{klass_method}" do
              klass.class_eval <<-EOS
                #{Readline::HISTORY.to_a.last.gsub(' ', '')}
              EOS
            end
          end
        end
      end

      Pry.config.commands.import(commands)
    end
  end
end