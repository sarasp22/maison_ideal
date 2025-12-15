# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create(email: "host@example.com", password: "password", role: "host", name: "Mario Rossi")

apartment = Apartment.create(
  title: "Cozy Flat",
  description: "A nice apartment in the city center",
  address: "123 Main Street",
  price: 100,
  host: user
)

booking = apartment.bookings.create(
  start_date: Date.today,
  end_date: Date.today + 3,
  total_price: 300,
  status: "pending",
  user: user
)
