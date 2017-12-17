class MemberSerializer < ActiveModel::Serializer
  attributes :id, :identity

  belongs_to :user

  def identity
    object.user.identities.main
  end
end
