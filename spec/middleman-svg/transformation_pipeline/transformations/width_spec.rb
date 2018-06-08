require 'spec_helper'
require 'middleman-svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations::Width do
  it "adds width attribute to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::Width.create_with_value("5%")

    expect(transformation.transform(document).to_html).to eq(
      "<svg width=\"5%\">Some document</svg>\n"
    )
  end
end
