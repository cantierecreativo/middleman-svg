module Middleman::Svg::TransformPipeline::Transformations
  class Height < Transformation
    def transform(doc)
      with_svg(doc) do |svg|
        svg["height"] = self.value
      end
    end
  end
end
