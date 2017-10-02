Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'] || "ZBmArlqyRLs3CRuZOuGJo10Ox", ENV['TWITTER_CONSUMER_SECRET'] || "y5SHsPwAKNuoLLh7IVobC9ctmIFEnapPfLy81ezc0EX8tDsQjo"
end
