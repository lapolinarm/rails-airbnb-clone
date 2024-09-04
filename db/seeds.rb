puts "Borrando usuarios, habitaciones, reservas y reseñas..."
User.destroy_all # Elimina todos los usuarios existentes
Room.destroy_all # Elimina todas las habitaciones existentes
Booking.destroy_all # Elimina todas las reservas existentes
Review.destroy_all # Elimina todas las reseñas existentes

puts "Creando usuarios aleatorios..."
40.times do
  user = User.create(
    first_name: Faker::Name.first_name, # Nombre aleatorio
    last_name: Faker::Name.last_name,   # Apellido aleatorio
    email: Faker::Internet.email,       # Email aleatorio
    password: "password"                # Contraseña fija para usuarios aleatorios
  )

  Room.create(
    name: Faker::Lorem.sentence(word_count: 3, supplemental: true), # Nombre descriptivo aleatorio
    description: Faker::Lorem.paragraph(sentence_count: 2),        # Descripción aleatoria
    address: Faker::Address.street_address + ", " + Faker::Address.city + ", " + Faker::Address.country, # Dirección en Latinoamérica
    capacity_max: rand(1..5),                                      # Capacidad máxima aleatoria entre 1 y 5
    pets: [true, false].sample,                                    # Permite mascotas aleatorio
    wifi: [true, false].sample,                                    # Tiene wifi aleatorio
    parking: [true, false].sample,                                 # Tiene estacionamiento aleatorio
    price: rand(100.0..1000.0).round(2),                           # Precio aleatorio entre 100 y 1000
    user: user                                                     # Asocia la habitación al usuario creado
  )
end

puts "Creando usuarios específicos..."
usuarios = [
  {email: "luis@gmail.com", first_name: "Luis", last_name: Faker::Name.last_name},
  {email: "jaime@gmail.com", first_name: "Jaime", last_name: Faker::Name.last_name},
  {email: "laura@gmail.com", first_name: "Laura", last_name: Faker::Name.last_name},
  {email: "levi@gmail.com", first_name: "Levi", last_name: Faker::Name.last_name}
]

usuarios.each do |user_data|
  user = User.create(
    first_name: user_data[:first_name],
    last_name: user_data[:last_name],
    email: user_data[:email],
    password: "123456"                   # Contraseña fija para usuarios específicos
  )

  Room.create(
    name: Faker::Lorem.sentence(word_count: 3, supplemental: true),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    address: Faker::Address.street_address + ", " + Faker::Address.city + ", " + Faker::Address.country,
    capacity_max: rand(1..5),
    pets: [true, false].sample,
    wifi: [true, false].sample,
    parking: [true, false].sample,
    price: rand(100.0..1000.0).round(2),
    user: user
  )
end

puts "Creando reservas..."
usuarios = User.all
habitaciones = Room.all

usuarios.each do |usuario|
  habitaciones.each do |habitacion|
    date_start = Faker::Date.between(from: 1.month.ago, to: Date.today) # Fecha de inicio
    date_finish = Faker::Date.between(from: date_start + 1.day, to: date_start + 30.days) # Fecha de fin, mayor que date_start

    Booking.create(
      date_start: date_start,                  # Fecha de inicio
      date_finish: date_finish,                # Fecha de fin
      final_price: habitacion.price,           # Precio final igual al de la habitación
      user: usuario,                          # Usuario que hace la reserva
      room: habitacion                        # Habitación reservada
    )
  end
end

puts "Creando reseñas..."
reservas = Booking.all

reservas.each do |reserva|
  Review.create(
    comment: Faker::Lorem.sentence(word_count: 10),  # Comentario aleatorio
    rating: rand(0.0..5.0).round(2),                 # Calificación aleatoria entre 0 y 5 con decimales
    booking: reserva                                # Reserva a la que pertenece la reseña
  )
end

puts "Proceso finalizado..."
