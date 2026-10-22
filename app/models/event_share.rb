class EventShare < ApplicationRecord
  belongs_to :event
  belongs_to :group

  validates :event_id, uniqueness: { scope: :group_id }
  validate :event_must_be_personal

  private

  # 共有できるのは個人予定のみ
  def event_must_be_personal
    errors.add(:event, "は個人予定のみ共有できます") if event && !event.personal?
  end
end
