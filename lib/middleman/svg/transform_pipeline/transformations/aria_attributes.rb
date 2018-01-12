module Middleman::Svg::TransformPipeline::Transformations
  class AriaAttributes < Transformation
    def transform(doc)
      with_svg(doc) do |svg|
        # Add role
        svg["role"] = "img"

        # Build aria-labelledby string
        aria_elements = []
        svg.search("title").each do |element|
          aria_elements << element["id"] = element_id_for("title", element)
        end

        svg.search("desc").each do |element|
          aria_elements << element["id"] = element_id_for("desc", element)
        end

        if aria_elements.any?
          svg["aria-labelledby"] = aria_elements.join(" ")
        end
      end
    end

    def element_id_for(base, element)
      if element["id"].nil?
        Middleman::Svg::IdGenerator.generate(base, element.text)
      else
        Middleman::Svg::IdGenerator.generate(element["id"], element.text)
      end
    end
  end
end
