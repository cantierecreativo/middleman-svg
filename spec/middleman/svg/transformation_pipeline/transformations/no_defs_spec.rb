require 'middleman/svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations::NoDefs do
  it "remove defs node to a SVG document" do
    document = Nokogiri::XML::Document.parse('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><defs><style>.a1b93b0f-7f32-4baf-897b-7e7d02bcfa21{fill:#fff;}</style></defs><title>Some Title</title>Some Document</svg>')
    transformation = Middleman::Svg::TransformPipeline::Transformations::NoDefs.create_with_value(true)

    expect(transformation.transform(document).to_html).to eq(
      "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\"><title>Some Title</title>Some Document</svg>\n"
    )
  end
end
