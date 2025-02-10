module Sha256Everything
  class TreeGenerator
    IGNORED_DIRECTORIES = ['.git'].freeze

    def initialize(root, results = {})
      @root = root
      @results = results
    end

    def generate
      lines = generate_lines(@root)
      max_length = lines.map { |line| line[:left].length }.max || 0
      header_left = 'File Hierarchy'
      header_right = 'SHA256 Hash'
      header_line = header_left.ljust(max_length + 4) + header_right
      tree_str = header_line + "\n\n"
      lines.each do |line|
        tree_str << line[:left].ljust(max_length + 4) + line[:right] + "\n"
      end
      tree_str
    end

    private

    def generate_lines(base, prefix = '')
      entries = visible_entries(base)
      lines = []
      entries.each_with_index do |entry, index|
        path = File.join(base, entry)
        connector = (index == entries.size - 1) ? "└── " : "├── "
        left_text = "#{prefix}#{connector}#{entry}"
        if File.file?(path)
          hash_value = @results[path] || '-'
          lines << { left: left_text, right: hash_value }
        else
          lines << { left: left_text, right: '' }
          extension = (index == entries.size - 1) ? "    " : "│   "
          lines.concat(generate_lines(path, prefix + extension))
        end
      end
      lines
    end

    def visible_entries(base)
      entries = Dir.entries(base) - %w[. ..]
      entries.reject { |entry| IGNORED_DIRECTORIES.include?(entry) }.sort
    end
  end
end
