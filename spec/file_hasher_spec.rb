require 'spec_helper'
require 'tmpdir'
require 'digest'

RSpec.describe Sha256Everything::FileHasher do
  let(:temp_file) { File.join(Dir.mktmpdir, 'test.txt') }

  before do
    File.write(temp_file, 'Content for hashing')
  end

  it 'computes the correct SHA256 hash' do
    hasher = described_class.new(temp_file)
    expected = Digest::SHA256.file(temp_file).hexdigest
    expect(hasher.compute).to eq(expected)
  end
end
