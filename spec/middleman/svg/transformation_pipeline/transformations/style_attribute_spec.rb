require "middleman/svg/transform_pipeline"

describe Middleman::Svg::TransformPipeline::Transformations::ClassAttribute do
  it "adds a style attribute to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg>Some document</svg>')
    transformation =
      Middleman::Svg::TransformPipeline::Transformations::StyleAttribute
        .create_with_value("padding: 10px")

    expect(transformation.transform(document).to_html).to eq(
      "<svg style=\"padding: 10px\">Some document</svg>\n"
    )
  end

  it "preserves existing style attributes on a SVG document" do
    xml = '<svg style="fill: red">Some document</svg>'
    document = Nokogiri::XML::Document.parse(xml)
    transformation =
      Middleman::Svg::TransformPipeline::Transformations::StyleAttribute
        .create_with_value("padding: 10px")

    expect(transformation.transform(document).to_html).to eq(
      "<svg style=\"fill: red;padding: 10px\">Some document</svg>\n"
    )
  end
end
