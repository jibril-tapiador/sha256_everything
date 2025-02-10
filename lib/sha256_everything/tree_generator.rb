module Sha256Everything
  class TreeGenerator
    attr_accessor :root

    def initialize(root)
      @root = root
    end

    def generate(prefix = '')
      entries = Dir.entries(@root) - %w[. ..]
      tree_str = ''
      entries.sort.each_with_index do |entry, index|
        path = File.join(@root, entry)
        connector = (index == entries.size - 1) ? "└── " : "├── "
        tree_str << "#{prefix}#{connector}#{entry}\n"
        if File.directory?(path)
          extension = (index == entries.size - 1) ? "    " : "│   "
          tree_str << TreeGenerator.new(path).generate(prefix + extension)
        end
      end
      tree_str
    end
  end
end
