class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :role, null: false, default: 0   # 0:member 1:admin 2:owner
      t.string  :display_name                    # グループ内での名前
      t.boolean :show_email, null: false, default: false
      t.boolean :show_phone, null: false, default: false

      t.timestamps
    end

    add_index :memberships, [:group_id, :user_id], unique: true
  end
end
