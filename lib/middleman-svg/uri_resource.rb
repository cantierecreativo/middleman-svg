module Middleman
  module Svg
    module URIResource
      def self.===(object)
        return false if object.is_a?(IO) || object.is_a?(StringIO)
        uri = URI.parse(object)
        uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
      end

      def self.read(object)
        str = open(object) { |f| f.read }
        str
      end
    end
  end
end
