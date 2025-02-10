require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::OutputWriter do
  let(:temp_file) { File.join(Dir.mktmpdir, 'output.txt') }
  let(:results) { { 'file.txt' => 'dummyhash' } }
  let(:tree)    { '└── file.txt\n' }

  it 'writes the expected content to the output file' do
    writer = described_class.new(temp_file, results, tree)
    writer.write
    content = File.read(temp_file)
    expect(content).to include('SHA256 Hashes:')
    expect(content).to include('file.txt: dummyhash')
    expect(content).to include('File Hierarchy:')
    expect(content).to include(tree.strip)
  end
end
