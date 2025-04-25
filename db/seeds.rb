# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email_address: "aykutalpturkay@icloud.com") do |user|
  user.password = "alp"
  user.first_name = "Aykut Alp"
  user.last_name = "Turkay"
end

User.find_or_create_by!(email_address: "elcinzorlu@alplotlib.com") do |user|
  user.password = "elçin"
  user.first_name = "Elçin"
  user.last_name = "Zorlu"
end

categories = [
  "Programming",
  "Tutorial",
  "Productivity",
  "Design",
  "Marketing",
  "Startup",
  "Career",
  "Ruby on Rails",
  "JavaScript",
  "DevOps"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end

puts "✅ Users seeded: #{User.count}"
puts "✅ Categories seeded: #{Category.count}"
