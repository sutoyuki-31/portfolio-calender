class Group < ApplicationRecord
  belongs_to :owner, class_name: "User", inverse_of: :owned_groups

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :events, dependent: :destroy                 # グループ予定
  has_many :event_shares, dependent: :destroy
  has_many :shared_events, through: :event_shares, source: :event  # 個人から共有された予定
  has_many :messages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  # 作成した親を owner として所属させる
  after_create :add_owner_membership

  # グループカレンダーに表示する予定(グループ予定 + 共有された個人予定)
  def calendar_events
    Event.where(id: events.select(:id))
         .or(Event.where(id: shared_events.select(:id)))
  end

  private

  def add_owner_membership
    memberships.create!(user: owner, role: :owner, display_name: owner.name)
  end
end
