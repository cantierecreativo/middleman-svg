require 'spec_helper'
require 'middleman-svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations::PreserveAspectRatio do
  it "adds preserveAspectRatio attribute to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::PreserveAspectRatio.create_with_value("xMaxYMax meet")
    expect(transformation.transform(document).to_html).to eq(
      "<svg preserveAspectRatio=\"xMaxYMax meet\">Some document</svg>\n"
    )
  end
end
