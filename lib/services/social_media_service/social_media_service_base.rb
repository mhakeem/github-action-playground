# frozen_string_literal: true

require 'logger'

class SocialMediaServiceBase
  def initialize
    @logger = AppLogger.instance
  end

  def post(message, **kwargs)
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  protected

  attr_reader :logger
end

# A singleton logger class
class AppLogger
  @instance = Logger.new($stdout)

  class << self
    attr_reader :instance
  end

  private_class_method :new
end
