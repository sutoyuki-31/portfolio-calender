class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.references :user,  null: false, foreign_key: true              # 作成者(個人予定ならカレンダーの持ち主)
      t.references :group, null: true,  foreign_key: true              # nullなら個人予定、あればグループ予定
      t.string   :title, null: false
      t.text     :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.boolean  :all_day, null: false, default: false

      t.timestamps
    end

    add_index :events, :starts_at
  end
end
