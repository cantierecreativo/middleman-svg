module Middleman::Svg
  class AssetFile
    class FileNotFound < IOError; end
    UNREADABLE_PATH = ''

    def self.named(filename)
      root = Middleman::Application.root
      asset_path = "#{root}/source/images/#{source}"
      File.read(asset_path || UNREADABLE_PATH)
    rescue Errno::ENOENT
      raise FileNotFound.new("Asset not found: #{asset_path}")
    end
  end
end
