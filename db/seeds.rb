# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.exists?
  email = ENV.fetch("EDWIG_ADMIN_EMAIL", "admin@exemple.com")
  User.create(email: email) do |user|
    puts "Create first user #{email}"

    generated_password = SecureRandom.hex
    puts "Password: #{generated_password}"
    user.password = generated_password
  end
end