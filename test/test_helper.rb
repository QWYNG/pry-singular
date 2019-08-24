$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "pry-singular"
require "minitest/autorun"
require "pry/testable"

Pry.color = false

def redirect_pry_io(new_in, new_out = StringIO.new)
  old_in = Pry.input
  old_out = Pry.output

  Pry.input = new_in
  Pry.output = new_out

  begin
    yield
  ensure
    Pry.input = old_in
    Pry.output = old_out
  end
end

def mock_pry(*args)
  binding = binding
  input = StringIO.new(args.join("\n"))
  output = StringIO.new

  redirect_pry_io(input, output) do
    Pry.start(binding, hooks: Pry::Hooks.new)
  end
  output.string
end
