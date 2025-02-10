require 'spec_helper'
require 'tmpdir'

RSpec.describe Sha256Everything::FileCollector do
  let(:temp_dir) { Dir.mktmpdir }

  before do
    # Create some files
    File.write(File.join(temp_dir, "file.txt"), "data")
    Dir.mkdir(File.join(temp_dir, "folder"))
    File.write(File.join(temp_dir, "folder", "nested.txt"), "nested")
    # Create a hidden file in the root directory
    File.write(File.join(temp_dir, ".hidden.txt"), "secret")
    # Create a .git folder with a file inside (which should be ignored)
    Dir.mkdir(File.join(temp_dir, ".git"))
    File.write(File.join(temp_dir, ".git", "ignored.txt"), "ignore me")
  end

  after do
    FileUtils.remove_entry(temp_dir)
  end

  it "collects all visible files recursively and excludes .git directory files" do
    collector = described_class.new(temp_dir)
    files = collector.files

    expect(files).to include(File.join(temp_dir, "file.txt"))
    expect(files).to include(File.join(temp_dir, "folder", "nested.txt"))
    expect(files).to include(File.join(temp_dir, ".hidden.txt"))
    # Ensure that any file from a .git folder is excluded
    expect(files.any? { |f| f.include?(".git") }).to be false
  end
end
