# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'debug'
require 'vcr'
require 'webmock/minitest'

Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(color: true)]
# Require your app files here so tests can access them easily
$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)
$LOAD_PATH.unshift File.expand_path('../../src', __dir__)

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

module FixtureHelper
  def fixture_path(filename)
    File.expand_path("../test/fixtures/#{filename}", __dir__)
  end

  def load_fixture(filename)
    File.read(fixture_path(filename))
  end
end

class Minitest::Test
  include FixtureHelper
end
