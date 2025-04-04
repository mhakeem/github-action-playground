# frozen_string_literal: true

require 'slack-ruby-client'
require_relative './social_media_service_base'

class SlackService < SocialMediaServiceBase
  SLACK_API_TOKEN = ENV.fetch('SLACK_API_TOKEN')
  SLACK_CHANNELS = ENV.fetch('SLACK_CHANNELS')

  def initialize
    super
    Slack.configure do |config|
      config.token = SLACK_API_TOKEN
    end

    @client = Slack::Web::Client.new
  end

  def post(message)
    post_to_channels(message)
  end

  private

  def post_to_channels(message)
    comma_regex = /\s*,\s*/
    channels = SLACK_CHANNELS.split(comma_regex)

    channels.each do |channel|
      @client.chat_postMessage(channel:, text: message, as_user: true)
      logger.info "Posted to Slack channel: #{channel}"
    rescue StandardError => e
      logger.error "Failed to post to #{channel}: #{e.message}"
    end
  end
end
