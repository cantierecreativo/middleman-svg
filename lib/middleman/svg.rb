require 'middleman/svg/version'
require 'middleman/svg/extension'

require "middleman/svg/asset_file"
require "middleman/svg/cached_asset_file"
require "middleman/svg/finds_asset_paths"
require "middleman/svg/static_asset_finder"
require "middleman/svg/transform_pipeline"
require "middleman/svg/io_resource"

require 'active_support/core_ext/string'
require 'nokogiri'

module Middleman
  module Svg
    class Configuration
      class Invalid < ArgumentError; end

      attr_reader :asset_file, :asset_finder, :custom_transformations, :svg_not_found_css_class

      def initialize
        @custom_transformations = {}
        @asset_file = Middleman::Svg::AssetFile
        @svg_not_found_css_class = nil
      end

      def asset_file=(custom_asset_file)
        begin
          method = custom_asset_file.method(:named)
          if method.arity == 1
            @asset_file = custom_asset_file
          else
            raise Middleman::Svg::Configuration::Invalid.new("asset_file should implement the #named method with arity 1")
          end
        rescue NameError
          raise Middleman::Svg::Configuration::Invalid.new("asset_file should implement the #named method")
        end
      end

      def asset_finder=(finder)
        @asset_finder = Middleman::Svg::StaticAssetFinder
        asset_finder
      end

      def svg_not_found_css_class=(css_class)
        if css_class.present? && css_class.is_a?(String)
          @svg_not_found_css_class = css_class
        end
      end

      def add_custom_transformation(options)
        if incompatible_transformation?(options.fetch(:transform))
          raise Middleman::Svg::Configuration::Invalid.new("#{options.fetch(:transform)} should implement the .create_with_value and #transform methods")
        end
        @custom_transformations.merge!(Hash[ *[options.fetch(:attribute, :no_attribute), options] ])
      end

      private

      def incompatible_transformation?(klass)
        !klass.is_a?(Class) || !klass.respond_to?(:create_with_value) || !klass.instance_methods.include?(:transform)
      end

    end

    @configuration = Middleman::Svg::Configuration.new

    class << self
      attr_reader :configuration

      def configure
        if block_given?
          yield configuration
        else
          raise Middleman::Svg::Configuration::Invalid.new('Please set configuration options with a block')
        end
      end

      def reset_configuration!
        @configuration = Middleman::Svg::Configuration.new
      end
    end
  end
end
