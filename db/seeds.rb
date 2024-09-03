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

%w[Rock Pop Electronic Jazz Hip-hop].each do |genre_music|
  3.times do
    vinyl = Vinyl.new(
      title: Faker::Music.album,
      artist: Faker::Music.band,
      genre: genre_music,
      price: Faker::Number.between(from: 40, to: 250),
      user_id: )
    vinyl.save
  end
end
