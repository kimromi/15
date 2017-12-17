class Team < ApplicationRecord
  has_many :members
  has_many :tasks
  has_many :records
  has_many :invitations

  enum deleted: { available: false, deleted: true }

  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 3..20 },
    format: { with: /\A[a-z0-9-]+\z/, message: 'Team name must be a combination of [a-z], [0-9] or `-`' }

  def current_invitaion
    if invitations.present?
      invitations.first
    else
      invitations.create!(
        token: SecureRandom.hex
      )
    end
  end
end
