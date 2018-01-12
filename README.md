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

## Options

key                     | description
:---------------------- | :----------
`id`                    | set a ID attribute on the SVG
`class`                 | set a CSS class attribute on the SVG
`style`                 | set a CSS style attribute on the SVG
`data`                  | add data attributes to the SVG (supply as a hash)
`size`                  | set width and height attributes on the SVG <br/> Can also be set using `height` and/or `width` attributes, which take precedence over `size` <br/> Supplied as "{Width} * {Height}" or "{Number}", so "30px\*45px" becomes `width="30px"` and `height="45px"`, and "50%" becomes `width="50%"` and `height="50%"`
`title`                 | add a \<title\> node inside the top level of the SVG document
`desc`                  | add a \<desc\> node inside the top level of the SVG document
`nocomment`             | remove comment tags from the SVG document
`preserve_aspect_ratio` | adds a `preserveAspectRatio` attribute to the SVG
`aria`                  | adds common accessibility attributes to the SVG
`aria_hidden`           | adds the `aria-hidden=true` attribute to the SVG

Example:

```ruby
inline_svg(
  "some-document.svg",
  id: 'some-id',
  class: 'some-class',
  data: {some: "value"},
  size: '30% * 20%',
  title: 'Some Title',
  desc: 'Some description',
  nocomment: true,
  preserve_aspect_ratio: 'xMaxYMax meet',
  aria: true,
  aria_hidden: true
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/middleman-svg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

