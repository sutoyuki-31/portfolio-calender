class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_EMAIL = "guest@example.com".freeze

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :owned_groups, class_name: "Group", foreign_key: :owner_id,
                          inverse_of: :owner, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, format: { with: /\A[0-9\-+]{10,15}\z/ }, allow_blank: true

  # ゲストログイン用
  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.guest = true
    end
  end

  # 個人カレンダー(グループに属さない予定)
  def personal_events
    events.where(group_id: nil)
  end
end
