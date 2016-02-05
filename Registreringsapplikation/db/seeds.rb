# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
u1 = User.create(:name => "Johanna", :role => "administrator", :email => "johanna@johanna.com", :password => "password", :password_confirmation => "password")
u2 = User.create(:email => "bempa@test.com", :password => "bempa", :password_confirmation => "bempa")

ApiKey.delete_all
a1 = ApiKey.create

a1.user = u2