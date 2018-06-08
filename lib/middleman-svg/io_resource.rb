module Middleman
  module Svg
    module IOResource
      def self.===(object)
        object.is_a?(IO) || object.is_a?(StringIO)
      end

      def self.read(object)
        start = object.pos
        str = object.read
        object.seek start
        str
      end
    end
  end
end
