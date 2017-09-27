class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  def self.from_omniauth(oauth)
    find_or_create_by(provider: oauth['provider'], uid: oauth['uid']) do |user|
      user.provider = oauth['provider']
      user.uid = oauth['uid']
      user.username = oauth['info']['nickname']
    end
  end
end
