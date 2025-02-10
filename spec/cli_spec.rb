require 'spec_helper'

RSpec.describe Sha256Everything::CLI do
  describe '.parse_options' do
    it 'parses the filename option correctly' do
      args = ['-f', 'output.txt']
      options = described_class.send(:parse_options, args)
      expect(options[:filename]).to eq('output.txt')
    end

    it 'parses the display_here flag correctly' do
      args = ['-d']
      options = described_class.send(:parse_options, args)
      expect(options[:display_here]).to be true
    end

    it 'uses default options when none are provided' do
      args = []
      options = described_class.send(:parse_options, args)
      expect(options[:filename]).to eq('hashes.txt')
      expect(options[:display_here]).to be false
    end
  end
end
