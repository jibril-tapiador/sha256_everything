require 'ruby-progressbar'

module Sha256Everything
  class Application
    def initialize(options)
      @directory   = options.fetch(:directory, Dir.pwd)
      @output_file = options.fetch(:filename, "hashes.txt")
      @display     = options.fetch(:display_here, false)
    end

    def run
      files     = FileCollector.new(@directory).files
      progress  = ProgressBar.create(total: files.size, format: '%a %B %p%% %t')
      results   = files.each_with_object({}) do |file, memo|
                    memo[file] = FileHasher.new(file).compute
                    progress.increment
                  end

      tree = TreeGenerator.new(@directory).generate
      OutputWriter.new(@output_file, results, tree).write
      puts "\nFile Hierarchy:" if @display
      puts tree if @display
    end
  end
end
