class AddCategoryToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :category, :integer
  end
end
