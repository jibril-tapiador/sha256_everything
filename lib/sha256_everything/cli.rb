require 'optparse'

module Sha256Everything
  class CLI
    def self.start(args = ARGV)
      options = parse_options(args)
      Application.new(options).run
    end

    def self.parse_options(args)
      # Set default options
      options = { filename: 'hashes.txt', display_here: false, directory: Dir.pwd }
      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: sha256-everything [options]'

        opts.on('-fNAME', '--filename=NAME', 'Set the output file name') do |name|
          options[:filename] = name
        end

        opts.on('-d', '--display_here', 'Display the file hierarchy in the terminal') do
          options[:display_here] = true
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end
      parser.parse!(args)
      options
    end
  end
end
