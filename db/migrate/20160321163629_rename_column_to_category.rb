class RenameColumnToCategory < ActiveRecord::Migration
  def change
    rename_column :creations, :group, :category
  end
end
