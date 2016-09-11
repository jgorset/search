# Search

This gem searches files and offers suggestions to narrow the search.

## Installation

    $ gem install jgorset-search

You'll need Ruby > 2.1.

## Usage

### Find files matching the given string

```sh
$ search 'foo' --files=spec/fixtures/*.txt
[100%] texts/just_the_word_foo.txt
[10%] texts/foo_and_other_words.txt
```

### Get suggestions for narrowing your search

```sh
$ suggest 'what is' --files=spec/fixtures/*.txt
what is the meaning of life?
what is my ip
what is pokemon go
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push git
commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jgorset/search.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
