class AddColumnDescriptionToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :description, :string
  end
end
