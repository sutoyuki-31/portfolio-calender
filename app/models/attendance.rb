class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user

  enum :status, { pending: 0, attend: 1, absent: 2 }

  validates :user_id, uniqueness: { scope: :event_id }
  validates :comment, length: { maximum: 200 }
end
