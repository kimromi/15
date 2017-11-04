class Team < ApplicationRecord
  has_many :members

  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 3..20 },
    format: { with: /\A[a-z0-9-]+\z/, message: 'Team name must be a combination of [a-z], [0-9] or `-`' }
end
