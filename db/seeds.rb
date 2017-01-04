# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Environment variables (ENV['...']) can be set in the file .env file.

user = User.new
user.name = 'Charlie Chrisman'
user.email = 'charlie.chrisman@gmail.com'
user.save

token = Token.generate(user)

user = User.new
user.name = 'Peter Schulz'
user.email = 'peter@theinformation.com'
user.save

token = Token.generate(user)

user = User.new
user.name = 'Ian Civgin'
user.email = 'ian@theinformation.com'
user.save

token = Token.generate(user)
