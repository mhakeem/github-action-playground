# frozen_string_literal: true

require 'bundler/setup'
require 'time'
require 'timezone'
require_relative 'lib/services/social_media_service/social_media_service_manager'

SocialMediaServiceManager.post_to_all("Hello World. #{Time.now(in: Timezone['America/Denver'])}")

puts "The time now is #{Time.now}"
# puts "Print secret env var #{ENV.fetch('SUPER_SECRET')}"
