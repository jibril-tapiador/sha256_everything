require 'ruby-progressbar'

module Sha256Everything
  class Application
    def initialize(options)
      @directory = options.fetch(:directory, Dir.pwd)
      @output_file = format_filename(options.fetch(:filename, 'hashes.txt'))
      @display = options.fetch(:display_here, false)
    end

    def run
      files = collect_files
      results = hash_files(files)
      tree = generate_tree(results)
      write_output(tree)

      display_progress_message
      display_tree(tree) if @display
    end

    private

    def format_filename(filename)
      filename.end_with?('.txt') ? filename : "#{filename}.txt"
    end

    def collect_files
      FileCollector.new(@directory).files
    end

    def hash_files(files)
      progress = create_progress_bar(files)
      files.each_with_object({}) do |file, memo|
        memo[file] = FileHasher.new(file).compute
        progress.increment
      end
    end

    def create_progress_bar(files)
      ProgressBar.create(total: files.size, format: '%a %B %p%% %t')
    end

    def generate_tree(results)
      TreeGenerator.new(@directory, results).generate
    end

    def write_output(tree)
      OutputWriter.new(@output_file, tree).write
    end

    def display_progress_message
      puts "\n\nHash file saved as #{@output_file}"
    end

    def display_tree(tree)
      puts "\n"
      puts tree
    end
  end
end
