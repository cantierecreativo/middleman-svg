# Middleman::Svg

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-svg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-svg

## Usage

Styling a SVG document with CSS for use on the web is most reliably achieved by adding classes to the document and embedding it inline in the HTML.
This gem adds a Middleman helper method (inline_svg) that reads an SVG document, applies a CSS class attribute to the root of the document and then embeds it into a view.

```ruby
svg_tag "file.svg", class: "some-class"
```

and so on.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/middleman-paginate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

