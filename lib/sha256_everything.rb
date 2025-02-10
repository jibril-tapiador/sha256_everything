# frozen_string_literal: true

require_relative 'sha256_everything/version'

require 'sha256_everything/version'
require 'sha256_everything/cli'
require 'sha256_everything/application'
require 'sha256_everything/file_collector'
require 'sha256_everything/file_hasher'
require 'sha256_everything/tree_generator'
require 'sha256_everything/output_writer'

module Sha256Everything
  class Error < StandardError; end
  # Your code goes here...
end
