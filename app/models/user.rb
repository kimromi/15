class User < ApplicationRecord
  has_many :identities

  Identity.providers.each do |provider, index|
    define_method "#{provider}_registered?" do
      identities.send(provider).present?
    end
  end
end
