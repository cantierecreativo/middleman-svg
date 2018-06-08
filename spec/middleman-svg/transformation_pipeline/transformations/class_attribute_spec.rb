require 'spec_helper'
require "middleman-svg/transform_pipeline"

describe Middleman::Svg::TransformPipeline::Transformations::ClassAttribute do
  it "adds a class attribute to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::ClassAttribute.create_with_value("some-class")

    expect(transformation.transform(document).to_html).to eq(
      "<svg class=\"some-class\">Some document</svg>\n"
    )
  end

  it "preserves existing class attributes on a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg class="existing things">Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::ClassAttribute.create_with_value("some-class")

    expect(transformation.transform(document).to_html).to eq(
      "<svg class=\"existing things some-class\">Some document</svg>\n"
    )
  end
end
