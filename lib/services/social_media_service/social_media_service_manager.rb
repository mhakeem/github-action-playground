# frozen_string_literal: true

require_relative './slack_service'
require_relative './mastodon_service'

# A factory like class to post to various social media services
class SocialMediaServiceManager
  PLATFORMS = {
    slack: -> { SlackService.new }
    # mastodon: -> { MastodonService.new }
  }.freeze

  def self.post_to_all(message)
    PLATFORMS.each_value do |service_proc|
      service = service_proc.call
      service.post(message)
    end
  end
end
