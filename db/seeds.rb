# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Chapter.create! [
    { creation_id: 1, title: "Chapter 1", text: "ololo text 1" },
    { creation_id: 1, title: "Chapter 2", text: "text TEXT text" },
    { creation_id: 1, title: "Chapter 3", text: "a bit more markdowned text" }
                ]