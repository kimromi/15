class Identity < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  class << self
    def find_or_create_with_omniauth(auth)
      find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    end
  end
end
