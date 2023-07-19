require "middleman-svg/asset_file"
require "middleman-svg/transform_pipeline"
require "middleman-svg/io_resource"
require "middleman-svg/uri_resource"
require 'middleman-svg/id_generator'

require 'uri'
require 'open-uri'
require 'nokogiri'

module Middleman
  module Svg
    class SvgExtension < Middleman::Extension
      expose_to_template :inline_svg

      def initialize(app, options_hash={}, &block)
        super

        require 'active_support/core_ext/string'
      end

      def inline_svg(filename, transform_params={})
        begin
          svg_file = Middleman::Svg::SvgExtension.read_svg(filename)
        rescue Middleman::Svg::AssetFile::FileNotFound
          return Middleman::Svg::SvgExtension.placeholder(filename) unless transform_params[:fallback].present?

          if transform_params[:fallback].present?
            begin
              svg_file = Middleman::Svg::SvgExtension.read_svg(transform_params[:fallback])
            rescue Middleman::Svg::AssetFile::FileNotFound
              Middleman::Svg::SvgExtension.placeholder(filename)
            end
          end
        end

        Middleman::Svg::TransformPipeline.generate_html_from(svg_file, transform_params).html_safe
      end

      def self.read_svg(filename)
        if Middleman::Svg::IOResource === filename
          Middleman::Svg::IOResource.read filename
        elsif Middleman::Svg::URIResource === filename
          Middleman::Svg::URIResource.read filename
        else
          Middleman::Svg::SvgExtension.asset_path(filename)
        end
      end

      def self.asset_path(source)
        root = Middleman::Application.root
        source_path = File.join(root, 'source')
        if File.exists?(File.join(source_path, 'images', source))
          File.read(File.join(source_path, 'images', source))
        elsif File.exists?(File.join(source_path, 'fonts/svg', source))
          File.read(File.join(source_path, 'fonts/svg', source))
        end
      end

      def self.placeholder(filename)
        css_class = Middleman::Svg.configuration.svg_not_found_css_class
        not_found_message = "'#{backwards_compatible_html_escape(filename)}' #{Middleman::Svg::SvgExtension.extension_hint(filename)}"

        if css_class.nil?
          return "<svg><!-- SVG file not found: #{not_found_message}--></svg>".html_safe
        else
          return "<svg class='#{css_class}'><!-- SVG file not found: #{not_found_message}--></svg>".html_safe
        end
      end

      def self.extension_hint(filename)
        filename.ends_with?(".svg") ? "" : "(Try adding .svg to your filename) "
      end

      def backwards_compatible_html_escape(filename)
        # html_escape_once was introduced in newer versions of Rails.
        if ERB::Util.respond_to?(:html_escape_once)
          ERB::Util.html_escape_once(filename)
        else
          ERB::Util.html_escape(filename)
        end
      end
    end
  end
end
