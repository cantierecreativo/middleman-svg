require "middleman-core"
require "middleman-svg/version"

::Middleman::Extensions.register(:inline_svg) do
  require "middleman-svg/extension"
  ::Middleman::Svg::SvgExtension
end
