require "pry-singular/version"
require 'pry'

module PrySingular
  class << self
    def set_class(*klasses)
      klasses.each(&method(:import_class_command))
    end

    private

    def import_class_command(klass)
      commands = Pry::CommandSet.new do
        klass.singleton_methods.each do |klass_method|
          command "#{klass_method}", "#{klass}.#{klass_method}" do
            klass.class_eval <<-EOS
              #{Readline::HISTORY.to_a.last.gsub(' ', '')}
            EOS
          end
        end
      end

      Pry.config.commands.import(commands)
    end
  end
end