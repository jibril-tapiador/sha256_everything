module Sha256Everything
  class OutputWriter
    def initialize(filename, results, tree)
      @filename = filename
      @results  = results
      @tree     = tree
    end

    def write
      File.open(@filename, 'w') do |f|
        f.puts 'SHA256 Hashes:'
        @results.each { |file, hash| f.puts "#{file}: #{hash}" }
        f.puts "\nFile Hierarchy:"
        f.puts @tree
      end
    end
  end
end
