class IdentitySerializer < ActiveModel::Serializer
  attributes :id, :email, :image, :nickname, :provider
end
