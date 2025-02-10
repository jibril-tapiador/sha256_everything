require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::OutputWriter do
  let(:temp_file) { File.join(Dir.mktmpdir, 'output.txt') }
  let(:tree) do
    <<~TREE
      File Heiarchy       SHA256 Hash

      └── file.txt       dummyhash
    TREE
  end

  it 'writes the expected content to the output file' do
    writer = described_class.new(temp_file, tree)
    writer.write
    content = File.read(temp_file)
    expect(content).to include('File Heiarchy')
    expect(content).to include('SHA256 Hash')
    expect(content).to include('└── file.txt')
    expect(content).to include('dummyhash')
  end
end
