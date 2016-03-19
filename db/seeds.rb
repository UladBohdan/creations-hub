# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
User.create! [
    {:id => 1, :name => "User 1"},
    {:id => 2, :name => "User 2"}
             ]

Creation.create! [
    {:id => 1, :user_id => 1, :title => "Test creation 1"},
    {:id => 2, :user_id => 1, :title => "Test creation 2"},
    {:id => 3, :user_id => 2, :title => "Test creation 3"},
    {:id => 4, :user_id => 2, :title => "Test creation 4"},
                 ]

=end