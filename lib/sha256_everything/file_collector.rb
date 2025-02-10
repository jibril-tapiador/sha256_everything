module Sha256Everything
  class FileCollector
    IGNORED_DIRECTORIES = ['.git'].freeze

    def initialize(directory)
      @directory = directory
    end

    def files
      pattern = File.join(@directory, '**', '{*,.*}')
      Dir.glob(pattern, File::FNM_DOTMATCH)
         .reject { |f| ignore?(f) }
         .select { |f| File.file?(f) }
    end

    private

    def ignore?(file)
      path_components = file.split(File::SEPARATOR)
      (path_components & IGNORED_DIRECTORIES).any?
    end
  end
end
