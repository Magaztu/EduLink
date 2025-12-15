# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create Admin User
admin_email = "admin@prrones.com"
unless User.exists?(email: admin_email)
  User.create!(
    nombre: "Admin Prron",
    email: admin_email,
    password: "admin123",
    password_confirmation: "admin123",
    type: "Client" # Admin acts as a client for now, but has special privileges
  )
  puts "Admin user created: #{admin_email} / admin123"
end

# Create some sample data if needed
# ...
