require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::Application do
  let(:temp_dir) { Dir.mktmpdir }
  let(:output_file) { File.join(temp_dir, 'test_hashes.txt') }

  before do
    # Create sample files and a subdirectory
    File.write(File.join(temp_dir, 'file1.txt'), 'Hello World')
    File.write(File.join(temp_dir, 'file2.txt'), 'Another file')
    Dir.mkdir(File.join(temp_dir, 'subdir'))
    File.write(File.join(temp_dir, 'subdir', 'file3.txt'), 'Subdir file')
  end

  after do
    FileUtils.remove_entry(temp_dir)
  end

  it 'processes files, writes output, and shows progress' do
    options = { filename: output_file, directory: temp_dir, display_here: true }
    expect { described_class.new(options).run }.to output(/Hash file saved as/).to_stdout

    content = File.read(output_file)
    expect(content).to include('File Hierarchy')
    expect(content).to include('SHA256 Hash')
    expect(content).to include('file1.txt')
    expect(content).to include('file2.txt')
    expect(content).to include('subdir')
    expect(content).to include('file3.txt')
  end
end
