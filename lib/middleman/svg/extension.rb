require 'middleman-core'
require 'middleman_dato/middleman_extension'

require "middleman/svg/asset_file"
require "middleman/svg/cached_asset_file"
require "middleman/svg/finds_asset_paths"
require "middleman/svg/static_asset_finder"
require "middleman/svg/transform_pipeline"
require "middleman/svg/io_resource"
require 'nokogiri'

module Middleman
  module Svg
    class Extension < ::Middleman::Extension
      def initialize(app, options_hash={}, &block)
        super
        require 'active_support/core_ext/string'
      end

      helpers do
        def svg_tag(filename, transform_params={})
          begin
            svg_file = Middleman::Svg::Extension.read_svg(filename)
          rescue Middleman::Svg::AssetFile::FileNotFound
            return Middleman::Svg::Extension.placeholder(filename) unless transform_params[:fallback].present?

            if transform_params[:fallback].present?
              begin
                svg_file = Middleman::Svg::Extension.read_svg(transform_params[:fallback])
              rescue Middleman::Svg::AssetFile::FileNotFound
                Middleman::Svg::Extension.placeholder(filename)
              end
            end
          end

          # Middleman::Svg::TransformPipeline.generate_html_from(svg_file, transform_params).html_safe
        end
      end

      def self.read_svg(filename)
        if Middleman::Svg::IOResource === filename
          Middleman::Svg::IOResource.read filename
        else
          Middleman::Svg::Extension.asset_path(filename)
        end
      end

      def self.asset_path(source)
        root = Middleman::Application.root
        file_path = "#{root}/source/images/#{source}"
        File.read(file_path) if File.exists?(file_path)
      end

      def self.placeholder(filename)
        css_class = Middleman::Svg.configuration.svg_not_found_css_class
        not_found_message = "'#{filename}' #{Middleman::Svg::Extension.extension_hint(filename)}"

        if css_class.nil?
          return "<svg><!-- SVG file not found: #{not_found_message}--></svg>".html_safe
        else
          return "<svg class='#{css_class}'><!-- SVG file not found: #{not_found_message}--></svg>".html_safe
        end
      end

      def self.configured_asset_file
        Middleman::Svg.configuration.asset_file
      end

      def self.extension_hint(filename)
        filename.ends_with?(".svg") ? "" : "(Try adding .svg to your filename) "
      end
    end
  end
end
