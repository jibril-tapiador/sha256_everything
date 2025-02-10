module Sha256Everything
  class FileCollector
    def initialize(directory)
      @directory = directory
    end

    def files
      Dir.glob(File.join(@directory, '**', '*')).select { |f| File.file?(f) }
    end
  end
end
