# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"
require "open-uri"

puts "Cleaning database..."
Review.destroy_all
Booking.destroy_all
Friend.destroy_all
User.destroy_all
file = URI.open(Faker::LoremFlickr.image)
puts "Creating a new user..."
3.times do
  User.create!(first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: "123456",
  birth_date: Faker::Date.birthday(min_age: 19, max_age: 65))
end

puts "Created #{User.count} users"

puts "Creating friends..."
User.all.each do |user|
    friend = Friend.new(first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.within(range: 19..65),
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    location: Faker::Address.city,
    interests: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Number.within(range: 10..100),
    start_date: Faker::Date.forward(days: 23),
    end_date: Faker::Date.forward(days: 30),
    activity: Faker::Lorem.word,
    user: user)
    file = URI.open(Faker::LoremFlickr.image)
    friend.image.attach(io: file, filename: "#{friend.first_name}.jpg", content_type: "image/jpg")
    friend.save!
  end

puts "Created #{Friend.count} friends"

puts "Creating bookings..."

User.all.each do |user|
  Friend.all.each do |friend|
    Booking.create!(activity: friend.activity,
    start_date: friend.start_date,
    end_date: friend.end_date,
    num_of_days: (friend.end_date - friend.start_date).to_i,
    user: user,
    friend: friend)
  end
end

puts "Created #{Booking.count} bookings"

puts "Creating reviews..."

User.all.each do |user|
  Friend.all.each do |friend|
    Booking.all.each do |booking|
      Review.create!(title: Faker::Lorem.sentence(word_count: 3),
      body: Faker::Lorem.paragraph(sentence_count: 2),
      rating: Faker::Number.within(range: 1..5),
      user: user,
      friend: friend,
      booking: booking)
    end
  end
end

puts "Created #{Review.count} reviews"

puts "Finished!"
