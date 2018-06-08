require 'spec_helper'
require 'middleman-svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations::Title do
  it "adds a title element as the first element in the SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::Title.create_with_value("Some Title")

    expect(transformation.transform(document).to_html).to eq(
      "<svg><title>Some Title</title>Some document</svg>\n"
    )
  end

  it "overwrites the content of an existing title element" do
    document = Nokogiri::XML::Document.parse('<svg><title>My Title</title>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::Title.create_with_value("Some Title")

    expect(transformation.transform(document).to_html).to eq(
      "<svg><title>Some Title</title>Some document</svg>\n"
    )
  end

  it "handles empty SVG documents" do
    document = Nokogiri::XML::Document.parse('<svg></svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::Title.create_with_value("Some Title")

    expect(transformation.transform(document).to_html).to eq(
      "<svg><title>Some Title</title></svg>\n"
    )
  end

  it "handles non-ASCII characters" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::Title.create_with_value("åäö")

    expect(transformation.transform(document).to_html).to eq(
      "<svg><title>åäö</title>Some document</svg>\n"
    )
  end
end
