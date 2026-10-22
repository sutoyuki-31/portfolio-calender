class CreateGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text   :description
      t.references :owner, null: false, foreign_key: { to_table: :users } # 親(作成者)

      t.timestamps
    end
  end
end
