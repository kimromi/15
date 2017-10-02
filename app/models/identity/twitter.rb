class Identity::Twitter < ApplicationRecord
  belongs_to :identity

  def tweets
    client.user_timeline
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
