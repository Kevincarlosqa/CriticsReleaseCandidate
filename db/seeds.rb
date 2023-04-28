# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"

companies_data = JSON.parse(File.read("db/data/companies.json"))
games_data = JSON.parse(File.read("db/data/games.json"))
genres_data = JSON.parse(File.read("db/data/genres.json"))
platforms_data = JSON.parse(File.read("db/data/platforms.json"))

puts "Start seeding"

Company.destroy_all
Platform.destroy_all
Genre.destroy_all
Game.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('companies')
ActiveRecord::Base.connection.reset_pk_sequence!('genres')
ActiveRecord::Base.connection.reset_pk_sequence!('platforms')
ActiveRecord::Base.connection.reset_pk_sequence!('games')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

puts "Seeding companies"
companies_data.each do |company_data|
  new_company = Company.new(company_data)
  new_company.cover.attach(io: File.open('db/imgs/sony.png'), filename: 'sony.png')
  puts "Company not created. Errors: #{new_company.errors.full_messages}" unless new_company.save
end

puts "Seeding platforms"
platforms_data.each do |platform_data|
  new_platform = Platform.new(platform_data)
  puts "Platform not created. Errors: #{new_platform.errors.full_messages}" unless new_platform.save
end

puts "Seeding genres"
genres_data.each do |name|
  new_genre = Genre.new(name: name)
  puts "Genre not created. Errors: #{new_genre.errors.full_messages}" unless new_genre.save
end

puts "Seeding main games and relationships"

main_games_data = games_data.select {|game| game["parent"].nil? }

main_games_data.each do |game|
  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.image.attach(io: File.open('db/imgs/nintendo.png'), filename: 'nintendo.png')
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

puts "Seeding expansion games and relationships"
expansions_games_data = games_data.select {|game| game["parent"].present? }

expansions_games_data.each do |game|
  parent_game = Game.find_by(name: game["parent"])

  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  new_game = Game.new(game_data)
  new_game.parent = parent_game
  puts "Game not created. Errors: #{new_game.errors.full_messages}" unless new_game.save

  game["genres"].each do |genre_name|
    new_game.genres << Genre.find_by(name: genre_name)
  end

  game["platforms"].each do |platform|
    new_game.platforms << Platform.find_by(name: platform["name"])
  end

  game["involved_companies"].each do |involved_company_data|
    company = Company.find_by(name: involved_company_data["name"])

    new_involved_company = InvolvedCompany.new( game: new_game,
                                                company: company,
                                                publisher: involved_company_data["publisher"], 
                                                developer: involved_company_data["developer"]
                                              )
    puts "Involved Company not created. Errors: #{new_involved_company.errors.full_messages}" unless new_involved_company.save
  end
end

company = Company.first
game = Game.first
game_2 = Game.last
company_2 = Company.last

user_1 = User.create(username: "user1", email: "user1@mail.com")
user_2 = User.create(username: "user2", email: "user2@mail.com")

Critic.create(title: "critic 1", body: "this is the first company critic", user_id: user_1, criticable: company)
Critic.create(title: "critic 10", body: "this is the tenth critic", user_id: user_1, criticable: game)
Critic.create(title: "critic 1", body: "this is the second company critic", user_id: user_2, criticable: company_2)
Critic.create(title: "critic 20", body: "this is the twentieth critic", user_id: user_2, criticable: game_2)