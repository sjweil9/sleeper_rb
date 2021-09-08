# SleeperRb
[![Gem Version](https://badge.fury.io/rb/simplecov-small-badge.svg)](https://badge.fury.io/rb/simplecov-small-badge)
[![Build Status](https://app.travis-ci.com/sjweil9/sleeper_rb.svg?branch=main)](https://app.travis-ci.com/sjweil9/sleeper_rb)

`SleeperRb` provides an object-oriented interface for the [Sleeper Fantasy
FootbalL API](https://docs.sleeper.app/#introduction). The Sleeper API is a
read-only, no-authentication API for accessing information on Sleeper Fantasy
Football leagues.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sleeper_rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sleeper_rb

## Usage

Initialize a `SleeperRb::Client` and use that to start any queries.

```ruby
client = SleeperRb::Client.new
```

Request resources from the client. The results will always be cached until you
call `refresh`.

```ruby
user = client.user(username: "foo")
=> #<SleeperRb::Resources::User:0x000056084a0c3d40 @username="foo">
```

From a given resource access its attributes or associated resources. No actual
web requests will be made until one of the attributes is accessed.

```ruby
user.user_id
=> 37440957478939283
user.display_name
=> "foobar"
# explicitly trigger a refresh to get, for example, an updated display_name
user.refresh.display_name
=> "newbar"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sjweil9/sleeper_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sleeper_rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SleeperRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sleeper_rb/blob/master/CODE_OF_CONDUCT.md).
