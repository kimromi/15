class Task < ApplicationRecord
  belongs_to :team

  enum deleted: { undeleted: false, deleted: true }
end
