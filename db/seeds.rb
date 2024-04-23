# frozen_string_literal: true

admin_user = User.create!(
  name: 'admin',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'admin',
  currency: 'USD'
)

puts "Admin user created: #{admin_user.email}"
