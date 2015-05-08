# pluck_into [![Build Status](https://travis-ci.org/pd/pluck_into.svg?branch=master)](https://travis-ci.org/pd/pluck_into)

`ActiveRecord::Base#pluck` is great, but I often find myself mapping over its return
value to wrap each row into a domain object of some kind.

`pluck_into` wraps that pattern up.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pluck_into'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pluck_into

## Usage

```ruby
results = FooRecord.pluck_into(SomeType, :bar, :baz)
results.first.bar
results.first.baz
```

## Caveats

Currently only supports objects with an `initialize` method similar to `OpenStruct`, `ActiveModel::Model`, etc:

```ruby
def initialize(attributes={})
```

This is the more common case in my usage. I would love to support plucking into a `Struct`, but haven't yet come up with a reasonable means of differentiating between the forms:

```ruby
BigWidget = Struct.new(:name, :size)
Widget.pluck_into(BigWidget, :name, :size)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/pd/pluck_into/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
