require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::TreeGenerator do
  let(:temp_dir) { Dir.mktmpdir }

  before do
    Dir.mkdir(File.join(temp_dir, 'dir1'))
    File.write(File.join(temp_dir, 'dir1', 'file1.txt'), 'data')
    Dir.mkdir(File.join(temp_dir, 'dir2'))
  end

  after do
    FileUtils.remove_entry(temp_dir)
  end

  it 'generates a tree that includes all directories and files' do
    tree = described_class.new(temp_dir).generate
    expect(tree).to include('dir1')
    expect(tree).to include('dir2')
    expect(tree).to include('file1.txt')
  end
end
