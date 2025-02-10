module Sha256Everything
  class OutputWriter
    def initialize(filename, tree_str)
      @filename = filename
      @tree_str = tree_str
    end

    def write
      File.open(@filename, 'w') do |f|
        f.puts @tree_str
      end
    end
  end
end
