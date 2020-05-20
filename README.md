# JustShogi

A shogi engine written in ruby. It provides a representation of a shogi game complete with rules enforcement and serialisation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'just_shogi'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install just_shogi

## Usage

To start, a new game state can be instantiated with the default state:

```ruby
  game_state = JustShogi::GameState.default
```

Moves can be made by passing in the player number and the from and to ids. It will return true if the move is valid, otherwise it will return false. The last argument is optional and if specified to true will attempt to promote the piece.

```ruby
  game_state.move(1, '77', '78', true)
```

Drops can be made by passing in the player number, the id of the piece in hand and the id of the square that the piece will be placed on. It will return true if the move is valid. Otherwise it will return false.

```ruby
  game_state.drop(1, 23, '78')
```

The last change with all its details are found in the `last_change` attribute.

```ruby
  game_state.last_change
```

If something unexpected happens, errors may be found in the errors attribute.

```ruby
  game_state.errors
```

The winner can be gound by calling winner on the object.

```ruby
  game_state.winner
```

Also, the game can be serialized into a hash.

```ruby
  game_state.as_json
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mrlhumphreys/just_shogi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mrlhumphreys/just_shogi/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JustShogi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mrlhumphreys/just_shogi/blob/master/CODE_OF_CONDUCT.md).
