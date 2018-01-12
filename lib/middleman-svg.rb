require 'middleman-core'
require 'middleman/svg'

Middleman::Extensions.register(:inline_svg, Middleman::Svg::Extension)
