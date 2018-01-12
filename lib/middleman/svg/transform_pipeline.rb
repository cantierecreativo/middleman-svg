module Middleman::Svg::TransformPipeline
  def self.generate_html_from(svg_file, transform_params)
    document = Nokogiri::XML::Document.parse(svg_file)
    Transformations.lookup(transform_params).reduce(document) do |doc, transformer|
      transformer.transform(doc)
    end.to_html
  end
end

require 'nokogiri'
require 'middleman/svg/id_generator'
require 'middleman/svg/transform_pipeline/transformations'