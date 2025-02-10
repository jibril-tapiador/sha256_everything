require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::TreeGenerator do
  let(:temp_dir) { Dir.mktmpdir }

  before do
    # Create two directories with a file inside one
    Dir.mkdir(File.join(temp_dir, "dir1"))
    File.write(File.join(temp_dir, "dir1", "file1.txt"), "data")
    Dir.mkdir(File.join(temp_dir, "dir2"))
    # Create a .git folder to test that it is ignored
    Dir.mkdir(File.join(temp_dir, ".git"))
    File.write(File.join(temp_dir, ".git", "config"), "some config")
  end

  after do
    FileUtils.remove_entry(temp_dir)
  end

  it "generates a tree that includes only visible directories and files" do
    tree = described_class.new(temp_dir).generate

    expect(tree).to include("dir1")
    expect(tree).to include("dir2")
    expect(tree).to include("file1.txt")
    # The .git folder and its contents should be excluded
    expect(tree).not_to include(".git")
  end

  it "includes a header with aligned columns" do
    tree = described_class.new(temp_dir).generate
    lines = tree.lines
    header_line = lines.first

    expect(header_line).to include("File Hierarchy")
    expect(header_line).to include("SHA256 Hash")

    # Ensure the header is followed by a blank line (as per our formatting)
    expect(lines[1].strip).to eq('')
  end
end
