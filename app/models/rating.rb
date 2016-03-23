class Rating < ActiveRecord::Base
  belongs_to :creation
  belongs_to :user

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

end
