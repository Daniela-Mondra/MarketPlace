# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# validates :genre, inclusion: { in: %w[Rock Pop Electronic Jazz Hip-hop] } require 'faker'
require 'faker'
require "open-uri"
require "json"

GENRES_MUSIC = %w[Rock Pop Electronic Jazz Hip-hop]

puts "Cleaning up database..."
Sale.destroy_all
Vinyl.destroy_all
User.destroy_all
puts "Database cleaned"

def base_user(user)
  initial_user = {
    email: user["email"],
    password: "password",
    first_name: user["name"]["first"],
    last_name: user["name"]["last"] || "Flores",
    address: Faker::Address.full_address
  }
  return User.new(initial_user)
end

def create_user
  url = "https://randomuser.me/api/?page=3&results=5&seed=abc"
  users = JSON.parse(URI.open(url).read)["results"]
  users.each do |user|
    file_name = user["id"]["value"] || user["name"]["first"]
    file = URI.parse(user["picture"]["large"]).open
    user_content = base_user(user)
    user_content.photo.attach(io: file, filename: file_name, content_type: "image/png")
    user_content.save
  end
end
users_count = User.all.count

if users_count.zero?
  puts "Creating users..."
  create_user
  puts "Users: #{User.all.count}"
end

def base_vinyl(album, users)
  initial_vinyl = {
    title: album['name'],
    artist: album["artists"][0]["name"],
    genre: GENRES_MUSIC.sample,
    price: Faker::Number.between(from: 40, to: 250),
    description: Faker::Music::SmashingPumpkins.lyric,
    user_id: users.flat_map { |u| u[:id] }.sample
  }
  return Vinyl.new(initial_vinyl)
end

def create_vinyl
  url = "https://api.spotify.com/v1/artists/0TnOYISbd1XYRBk9myaseg/albums?limit=15"
  users = User.all
  albums = JSON.parse(URI.open(url, "Authorization" => ENV['API_TOKEN']).read)["items"]
  albums.each do |album|
    file = URI.parse(album["images"][0]["url"]).open
    vinyl = base_vinyl(album, users)
    vinyl.photo.attach(io: file, filename: album["id"], content_type: "image/png")
    vinyl.save
  end
end

puts "Creating vinyls..."
create_vinyl
puts "Vinyls: #{Vinyl.all.count}"

# users = User.all
# users_id = users.flat_map { |u| u[:id] }

# vinyls = Vinyl.all
# vinyls_id = vinyls.flat_map { |u| u[:id] }

# 3.times do
#   Sale.create(vinyl_id: vinyls_id.sample, user_id: users_id.sample)
# end
