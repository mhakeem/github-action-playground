# frozen_string_literal: true

require 'bundler/setup'
require 'time'
require 'timezone'
require 'slack-ruby-client'

SLACK_API_TOKEN = ENV.fetch('SLACK_API_TOKEN')

Slack.configure do |config|
  config.token = SLACK_API_TOKEN
end

client = Slack::Web::Client.new

client.chat_postMessage(
  channel: '#test-channel-1',
  text: "Hello World. #{Time.now(in: Timezone['America/Denver'])}",
  as_user: true)


puts "The time now is #{Time.now}"
puts "Print secret env var #{ENV.fetch('SUPER_SECRET')}"
