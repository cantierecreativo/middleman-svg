require 'middleman/svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations::IdAttribute do
  it "adds an id attribute to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::IdAttribute.create_with_value("some-id")

    expect(transformation.transform(document).to_html).to eq(
      "<svg id=\"some-id\">Some document</svg>\n"
    )
  end
end
