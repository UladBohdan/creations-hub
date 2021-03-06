class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title, default: "New Chapter"
      t.text :text
      t.references :creation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
