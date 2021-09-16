# SleeperRb
[![Gem Version](https://badge.fury.io/rb/sleeper_rb.svg)](https://badge.fury.io/rb/sleeper_rb)
[![Build Status](https://app.travis-ci.com/sjweil9/sleeper_rb.svg?branch=main)](https://app.travis-ci.com/sjweil9/sleeper_rb)

`SleeperRb` provides an object-oriented interface for the [Sleeper Fantasy
Football API](https://docs.sleeper.app/#introduction). The Sleeper API is a
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

From a given resource access its attributes or associated resources. No
API requests will be made until one of the attributes is accessed.

```ruby
user.user_id
=> 37440957478939283
user.display_name
=> "foobar"
# explicitly trigger a refresh to get, for example, an updated display_name
user.refresh.display_name
=> "newbar"
```

Some resources also have associations to other types of resources.

```ruby
roster.players
=> [#<SleeperRb::Resources::Player:0x00005588808d2c60 @player_id="1479">,...]
```

Any resources returned as an array implement a ResourceArray variation that enables
a light ActiveRecord-inspired syntax for filtering the collection.

```ruby
roster.players.class
=> SleeperRb::Resources::PlayerArray
roster.players.where(position: "rb")
=> [#<SleeperRb::Resources::Player:0x00005588808d2828 @player_id="2431", @values=...]
roster.players.where(age: { lt: 25 })
=> [#<SleeperRb::Resources::Player:0x00005588808d2828 @player_id="2431", @values=...]
```

Check the [complete
documentation](https://sjweil9.github.io/sleeper_rb/SleeperRb/Client.html) to
see all possible resources that can be accessed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sjweil9/sleeper_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sleeper_rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SleeperRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sleeper_rb/blob/master/CODE_OF_CONDUCT.md).
