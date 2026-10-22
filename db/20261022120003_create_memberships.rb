class CreateEventShares < ActiveRecord::Migration[7.2]
  def change
    create_table :event_shares do |t|
      t.references :event, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :event_shares, [:event_id, :group_id], unique: true
  end
end
