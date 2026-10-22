class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum :role, { member: 0, admin: 1, owner: 2 }

  validates :user_id, uniqueness: { scope: :group_id }
  validates :display_name, length: { maximum: 50 }

  before_validation :set_default_display_name, on: :create

  # 管理権限(チャット開設・権限付与・予定作成)を持つか
  def manager?
    owner? || admin?
  end

  private

  def set_default_display_name
    self.display_name = user&.name if display_name.blank?
  end
end
