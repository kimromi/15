class User < ApplicationRecord
  has_many :members
  has_many :teams, through: :members
  has_many :identities

  Identity.providers.each do |provider, index|
    define_method "#{provider}_registered?" do
      identities.send(provider).present?
    end

    define_method "#{provider}" do
      return nil if identities.send(provider).empty?
      identities.send(provider).first.send("identity_#{provider}")
    end
  end
end
