class RenameCategoryColumnName < ActiveRecord::Migration
  def change
    rename_column :creations, :category, :group
  end
end
