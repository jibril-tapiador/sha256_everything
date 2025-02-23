module Sha256Everything
  class FileCollector
    IGNORED_DIRECTORIES = ['.git'].freeze

    attr_accessor :directory

    def initialize(directory)
      @directory = directory
    end

    def files
      Dir.glob(file_pattern, File::FNM_DOTMATCH)
         .select { |file| valid_file?(file) }
    end

    private

    def file_pattern
      File.join(@directory, '**', '{*,.*}')
    end

    def valid_file?(file)
      File.file?(file) && !ignored_directory?(file)
    end

    def ignored_directory?(file)
      file.split(File::SEPARATOR).any? { |component| IGNORED_DIRECTORIES.include?(component) }
    end
  end
end
