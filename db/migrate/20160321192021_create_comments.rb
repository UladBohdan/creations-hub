class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :creation, index: true, foreign_key: true
      t.text :text, null: false, default: "Default comment"

      t.timestamps null: false
    end
  end
end
