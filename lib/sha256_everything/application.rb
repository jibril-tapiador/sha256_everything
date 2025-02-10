require 'ruby-progressbar'

module Sha256Everything
  class Application
    def initialize(options)
      @directory = options.fetch(:directory, Dir.pwd)
      file_name = options.fetch(:filename, "hashes.txt")
      @output_file = file_name.end_with?(".txt") ? file_name : "#{file_name}.txt"
      @display     = options.fetch(:display_here, false)
    end

    def run
      files = FileCollector.new(@directory).files
      progress = ProgressBar.create(total: files.size, format: '%a %B %p%% %t')
      results = files.each_with_object({}) do |file, memo|
        memo[file] = FileHasher.new(file).compute
        progress.increment
      end

      # Generate formatted tree (including hash values)
      tree = TreeGenerator.new(@directory, results).generate
      OutputWriter.new(@output_file, tree).write

      # Display message after progress bar finishes
      puts "\n\nHash file saved as #{@output_file}"
      puts "\n" if @display
      puts tree if @display
    end
  end
end
