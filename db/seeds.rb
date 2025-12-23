puts "🧹 Cleaning database..."

Booking.destroy_all
Apartment.destroy_all
User.destroy_all

puts "👤 Creating users..."

host = User.create!(
  email: "host@example.com",
  password: "password",
  role: :host,
  name: "Mario Host"
)

tenant = User.create!(
  email: "tenant@example.com",
  password: "password",
  role: :tenant,
  name: "Mario Tenant"
)

puts "🏠 Creating apartment..."

apartment = host.apartments.create!(
  title: "Cozy Flat",
  description: "A nice apartment in the city center",
  address: "123 Main Street",
  price: 100,
  guests: 2
)

puts "📅 Creating booking..."

booking = apartment.bookings.create!(
  start_date: Date.today,
  end_date: Date.today + 3,
  total_price: 300,
  status: "pending",
  user: tenant
)

puts "💰 Creating payment..."

Payment.create!(
  amount: booking.total_price,
  status: "pending",
  booking: booking,
  user: tenant
)

puts "✅ Seed completed!"
