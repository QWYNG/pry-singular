# Pry-Singular
blog https://sasa5740.hatenablog.com/entry/2019/07/15/205709


[![Build Status](https://travis-ci.org/QWYNG/pry-singular.svg?branch=master)](https://travis-ci.org/QWYNG/pry-singular)  
　
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pry-singular'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pry-singular

## Usage
Set `.pryrc` as below  

```ruby
PrySingular.make_commands FooJob, FactoryBot
```

then you can use singular method of set class as pry command

    pry(main)> perform_now

also you can use argument 

    pry(main)> create :user
    
Pry-Singular add only `singleton_methods(true)` for do not create core Ruby methods commands

If you have a method you want to specify write　as below

```ruby
PrySingular.make_commands FactoryBot, only: [:build, :attributes_for]
```

Also, If you have a method that you don't want to command

```ruby
PrySingular.make_commands FactoryBot, except: :create
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/QWYNG/pry-singular. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pry::Singular project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/QWYNG/pry-singular/blob/master/CODE_OF_CONDUCT.md).
