require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::FileCollector do
  let(:temp_dir) { Dir.mktmpdir }

  before do
    File.write(File.join(temp_dir, 'file.txt'), 'data')
    Dir.mkdir(File.join(temp_dir, 'folder'))
    File.write(File.join(temp_dir, 'folder', 'nested.txt'), 'nested')
  end

  after do
    FileUtils.remove_entry(temp_dir)
  end

  it 'collects all files recursively' do
    collector = described_class.new(temp_dir)
    files = collector.files
    expect(files.size).to eq(2)
    expect(files.any? { |f| f.include?('file.txt') }).to be true
    expect(files.any? { |f| f.include?('nested.txt') }).to be true
  end
end
