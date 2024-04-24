# frozen_string_literal: true

admin_user = User.find_or_create_by!(
  email: 'admin@example.com'
) do |user|
  user.name = 'admin'
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'admin'
  user.currency = 'USD'
end

puts "Admin user created: #{admin_user.email}"

# Customer
customer = User.find_or_create_by!(
  email: 'customer1@bloobloom.com'
) do |user|
  user.name = 'customer1'
  user.password = 'customer123'
  user.password_confirmation = 'customer123'
  user.currency = 'USD'
end

# Frame
frame = Frame.find_or_create_by!(
  name: 'Frame1'
) do |f|
  f.description = 'A sleek black frame with a modern design'
  f.status = 'active'
  f.stock = 10
  f.prices.build(amount: 10, currency: 'USD')
end

# Lens
lens = Lens.find_or_create_by!(
  description: 'classic Red fashion lens'
) do |l|
  l.prescription_type = 'fashion'
  l.lens_type = 'classic'
  l.colour = 'Red'
  l.stock = 10
  l.prices.build(amount: 10, currency: 'USD')
end

# Shopping Basket
shopping_basket = ShoppingBasket.find_or_create_by!(user_id: customer.id)

# Glass
Glass.find_or_create_by!(
  lens:,
  frame:,
  shopping_basket:
)
