class Record < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :task
end
