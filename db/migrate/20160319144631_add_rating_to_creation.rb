class AddRatingToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :rating, :integer, default: 0
  end
end
