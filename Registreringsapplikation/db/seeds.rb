# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
u1 = User.create(:role => "administrator", :email => "johanna@johanna.com", :password => "password", :password_confirmation => "password")

ApiKey.delete_all
key = ApiKey.create(:app_name => "coola appen")
key.user = u1
key.save


game = Game.create( home_score: "67", away_score: "55" )
hometeam = Team.create( name: "Borås basket" )
awayteam = Team.create( name: "Göteborgs basket" )

game.home_team = hometeam
game.away_team = awayteam

Location.delete_all
location1 = Location.create(:address => "Eiffel Tower")
location2 = Location.create(:address => "Statue of Liberty")

location1.save
location2.save

game.location = location1

game.save

Tag.delete_all
tag = Tag.create(:name => "Ladies div2")
tag.save