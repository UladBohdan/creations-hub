class CreateCreations < ActiveRecord::Migration
  def change
    create_table :creations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title, null: false, default: "New creation"

      t.timestamps null: false
    end
  end
end
