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
# require 'faker'
# users = User.all.count

# if users.zero?
#   5.times do
#     name, last_name = Faker::Name.name.split

#     initial_user = {
#       email: "#{name}@gmail.com",
#       password: "password",
#       first_name: name,
#       last_name: last_name || "Flores",
#       address: Faker::Address.full_address
#     }
#     User.create(initial_user)
#   end

#   puts User.all
# end

# users = User.all
# %w[Rock Pop Electronic Jazz Hip-hop].each do |genre_music|
#   3.times do
#     initial_vinyl = {
#       title: Faker::Music.album,
#       artist: Faker::Music.band,
#       genre: genre_music,
#       price: Faker::Number.between(from: 40, to: 250),
#       user_id: users.flat_map { |u| u[:id] }.sample
#     }
#     Vinyl.create(initial_vinyl)
#   end
# end
# puts Vinyl.all

users = User.all
users_id = users.flat_map { |u| u[:id] }
# puts users_id
# puts "##############"
vinyls = Vinyl.all
vinyls_id = vinyls.flat_map { |u| u[:id] }
# puts vinyls_id
# puts "##############"

3.times do
  Sale.create(vinyl_id: vinyls_id.sample, user_id: users_id.sample)
end
