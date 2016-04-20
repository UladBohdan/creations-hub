# Creations Hub

Web site to handle with "Creations" (Books/Blogs/...): to create new ones, to edit them, to read creations created by others.

## Installation

You may not only view deployed version [here](http://creations-hub.herokuapp.com/), but try to run it locally. To do this:

make sure you have Ruby, Rails, bower, PostgreSQL installed on your computer

clone the repository `git clone https://github.com/UladBohdan/creations-hub.git`

go to the directory with repository cloned 'cd creations-hub'

install all the gems: `bundle`

install all the dependencies for front-end: `bower install`

setup `PG_USERNAME`, `PG_PASSWORD` & `SECRET_KEY_BASE` variables or simply modify `config/database.yml` file

run the project `rails s`

go to `localhost:3000` and enjoy!

## Technologies used

Rails 4.2 for server; AngularJS 1.5 for client