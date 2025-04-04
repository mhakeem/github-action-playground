# frozen_string_literal: true

require 'mastodon'
require_relative './social_media_service_base'

class MastodonService < SocialMediaServiceBase
  MASTODON_API_TOKEN = ENV.fetch('MASTODON_API_TOKEN')
  MASTODON_BASE_URL = ENV.fetch('MASTODON_BASE_URL')

  def initialize
    super
    @client = Mastodon::REST::Client.new(
      base_url: MASTODON_BASE_URL,
      bearer_token: MASTODON_API_TOKEN
    )
  end

  def post(message)
    @client.create_status(message)
    logger.info "Posting to Mastodon: #{message}"
  rescue StandardError => e
    logger.error "Error posting to Mastodon: #{e.message}"
  end
end
