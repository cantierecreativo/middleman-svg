module Middleman::Svg::TransformPipeline
  module Transformations
    class NoDefs < Transformation
      def transform(doc)
        with_svg(doc) do |svg|
          svg.at_css("defs").remove
        end
      end
    end
  end
end
