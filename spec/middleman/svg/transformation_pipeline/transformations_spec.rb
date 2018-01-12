require 'middleman/svg'
require 'middleman/svg/transform_pipeline'

describe Middleman::Svg::TransformPipeline::Transformations do
  context "looking up transformations" do
    it "returns built-in transformations when parameters are supplied" do
      transformations = Middleman::Svg::TransformPipeline::Transformations.lookup(
        nocomment: 'irrelevant',
        no_defs: "true",
        class: 'irrelevant',
        style: 'irrelevant',
        title: 'irrelevant',
        desc: 'irrelevant',
        size: 'irrelevant',
        height: 'irrelevant',
        width: 'irrelevant',
        id: 'irrelevant',
        data: 'irrelevant',
        preserve_aspect_ratio: 'irrelevant',
        aria: 'irrelevant',
        aria_hidden: "true",
      )

      expect(transformations.map(&:class)).to match_array([
        Middleman::Svg::TransformPipeline::Transformations::NoComment,
        Middleman::Svg::TransformPipeline::Transformations::NoDefs,
        Middleman::Svg::TransformPipeline::Transformations::ClassAttribute,
        Middleman::Svg::TransformPipeline::Transformations::StyleAttribute,
        Middleman::Svg::TransformPipeline::Transformations::Title,
        Middleman::Svg::TransformPipeline::Transformations::Description,
        Middleman::Svg::TransformPipeline::Transformations::Size,
        Middleman::Svg::TransformPipeline::Transformations::Height,
        Middleman::Svg::TransformPipeline::Transformations::Width,
        Middleman::Svg::TransformPipeline::Transformations::IdAttribute,
        Middleman::Svg::TransformPipeline::Transformations::DataAttributes,
        Middleman::Svg::TransformPipeline::Transformations::PreserveAspectRatio,
        Middleman::Svg::TransformPipeline::Transformations::AriaAttributes,
        Middleman::Svg::TransformPipeline::Transformations::AriaHiddenAttribute
      ])
    end

    it "returns transformations in priority order" do
      built_ins = {
        desc:   { transform: Middleman::Svg::TransformPipeline::Transformations::Description, priority: 1 },
        size:   { transform: Middleman::Svg::TransformPipeline::Transformations::Size },
        title:  { transform: Middleman::Svg::TransformPipeline::Transformations::Title, priority: 2 }
      }

      allow(Middleman::Svg::TransformPipeline::Transformations).to \
        receive(:built_in_transformations).and_return(built_ins)

      transformations = Middleman::Svg::TransformPipeline::Transformations.lookup(
        {
          desc: "irrelevant",
          size: "irrelevant",
          title: "irrelevant",
        }
      )

      expect(transformations.map(&:class)).to eq([
        Middleman::Svg::TransformPipeline::Transformations::Description,
        Middleman::Svg::TransformPipeline::Transformations::Title,
        Middleman::Svg::TransformPipeline::Transformations::Size,
      ])
    end

    it "returns no transformations when asked for an unknown transform" do
      transformations = Middleman::Svg::TransformPipeline::Transformations.lookup(
        not_a_real_transform: 'irrelevant'
      )

      expect(transformations.map(&:class)).to match_array([])
    end

    it "does not return a transformation when a value is not supplied" do
      transformations = Middleman::Svg::TransformPipeline::Transformations.lookup(
        title: nil
      )

      expect(transformations.map(&:class)).to match_array([])
    end
  end
end
