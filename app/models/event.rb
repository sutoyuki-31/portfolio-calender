class Event < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true      # nilなら個人予定

  has_many :event_shares, dependent: :destroy
  has_many :shared_groups, through: :event_shares, source: :group
  has_many :attendances, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :starts_at, presence: true
  validate :ends_at_after_starts_at

  scope :personal, -> { where(group_id: nil) }

  def personal?
    group_id.nil?
  end

  private

  def ends_at_after_starts_at
    return if ends_at.blank? || starts_at.blank?
    errors.add(:ends_at, "は開始日時より後にしてください") if ends_at < starts_at
  end
end
