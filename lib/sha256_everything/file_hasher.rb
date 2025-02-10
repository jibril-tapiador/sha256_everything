require 'digest'

module Sha256Everything
  class FileHasher
    def initialize(file)
      @file = file
    end

    def compute
      Digest::SHA256.file(@file).hexdigest
    rescue StandardError => e
      "Error: #{e.message}"
    end
  end
end
