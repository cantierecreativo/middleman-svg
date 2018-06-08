module Middleman::Svg::TransformPipeline::Transformations
  class AriaHidden < Transformation
    def transform(doc)
      with_svg(doc) do |svg|
        svg["aria-hidden"] = self.value
      end
    end
  end
end
