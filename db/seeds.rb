puts "Borrando usuarios..."
User.destroy_all

puts "Creando usuarios..."
User.create(first_name: "Laura", last_name: "Ramirez", email: "lrodar23m@gmail.com", password: "12345678")
5.times do
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password")
  Room.create(name: Faker::Lorem.word, description: Faker::Lorem.sentence, address: Faker::Address.street_address, capacity_max: 5, pets: true, wifi: true, parking: true, price: 100, user: user)
end

puts "Proceso finalizado..."
