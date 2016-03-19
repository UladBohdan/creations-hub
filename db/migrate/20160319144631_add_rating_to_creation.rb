class AddRatingToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :rating, :integer
  end
end
