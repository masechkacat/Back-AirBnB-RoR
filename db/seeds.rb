# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# db/seeds.rb

# Подключаем гем Faker
require 'faker'

User.destroy_all
City.destroy_all
Listening.destroy_all
Reservation.destroy_all

# Создаем пользователей
20.times do
  User.create(
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    description: Faker::Lorem.paragraph
  )
end

# Создаем города
10.times do
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

# Создаем жилье
50.times do
  Listening.create(
    available_beds: Faker::Number.between(from: 1, to: 5),
    price: Faker::Number.between(from: 30, to: 200),
    description: Faker::Lorem.paragraph,
    has_wifi: [true, false].sample,
    welcome_message: Faker::Lorem.sentence,
    admin_id: User.pluck(:id).sample, # Выбираем случайного пользователя
    city_id: City.pluck(:id).sample  # Выбираем случайный город
  )
end

# Создаем бронирования для каждого жилья
Listening.all.each do |listing|
    5.times do
      start_date = Faker::Date.backward(days: 30) # Бронирование в прошлом
      end_date = start_date + rand(2..7).days # Продолжительность бронирования от 2 до 7 дней
      Reservation.create(
        start_date: start_date,
        end_date: end_date,
        guest_id: User.pluck(:id).sample,
        listing_id: listing.id
      )
    end
  
    5.times do
      start_date = Faker::Date.forward(days: 30) # Бронирование в будущем
      end_date = start_date + rand(2..7).days
      Reservation.create(
        start_date: start_date,
        end_date: end_date,
        guest_id: User.pluck(:id).sample,
        listing_id: listing.id
      )
    end
  end
  
