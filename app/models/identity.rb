class Identity < ApplicationRecord
  belongs_to :user
  has_one :identity_twitter, class_name: Identity::Twitter
  has_one :identity_github, class_name: Identity::Github

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  enum provider: { twitter: 0, github: 1 }

  class << self
    def find_or_create_with_omniauth(auth)
      find_or_create_by(uid: auth['uid'], provider: auth['provider'].to_sym)
    end

    def main
      github.first
    end
  end

  def create_user_with_omniauth!(auth)
    create_user!(
      name: auth['info']['nickname']
    )
  end

  def save_with_omniauth!(auth)
    self.nickname = auth['info']['nickname']
    self.email = auth['info']['email']
    self.image = auth['info']['image']
    save!

    case provider.to_sym
    when :twitter
      create_identity_twitter!(
        token: auth['credentials']['token'],
        secret: auth['credentials']['secret']
      )
    when :github
      create_identity_github!(
        token: auth['credentials']['token']
      )
    end
  end
end
