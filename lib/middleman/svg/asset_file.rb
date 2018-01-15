module Middleman::Svg
  class AssetFile
    class FileNotFound < IOError; end
    UNREADABLE_PATH = ''

    def self.named(filename)
      root = Middleman::Application.root
      source_path = File.join(root, 'source')
      File.read(File.join(source_path, 'images', source) || File.join(source_path, 'fonts/svg', source) || UNREADABLE_PATH)
    rescue Errno::ENOENT
      raise FileNotFound.new("Asset not found: #{asset_path}")
    end
  end
end
