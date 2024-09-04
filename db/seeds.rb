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
puts "Database cleaned"

def create_user(name, last_name)
  initial_user = {
    email: "#{name}@gmail.com",
    password: "password",
    first_name: name,
    last_name: last_name || "Flores",
    address: Faker::Address.full_address
  }
  User.create(initial_user)
end

users_count = User.all.count

if users_count.zero?
  5.times do
    name, last_name = Faker::Name.name.split
    create_user(name, last_name)
  end

  puts User.all
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

create_vinyl
puts Vinyl.all

# users = User.all
# users_id = users.flat_map { |u| u[:id] }

# vinyls = Vinyl.all
# vinyls_id = vinyls.flat_map { |u| u[:id] }

# 3.times do
#   Sale.create(vinyl_id: vinyls_id.sample, user_id: users_id.sample)
# end
