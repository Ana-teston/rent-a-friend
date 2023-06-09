# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"
require "open-uri"
require "geocoder"

puts "Cleaning database..."
Review.destroy_all
Booking.destroy_all
Friend.destroy_all
User.destroy_all

# give me a random array of interests

interests = [
  "🏀 Sports",
  "🎸 Music",
  "🍔 Food",
  "🎨 Art",
  "🏛 History",
  "🌳 Nature",
  "🎭 Culture",
  "🍸 Nightlife",
  "🛍 Shopping",
  "🏛 Architecture",
  "📸 Photography",
  "🐶 Animals",
   "🏛 Museums",
   "🏖 Beaches",
  "🥾 Hiking",
   "🚴‍♀️ Cycling",
   "🏛 Sightseeing",
   "🧘‍♀️ Relaxing",
   "💃 Dancing",
   "👩‍🍳 Cooking"
]
# give me an array of random bio
bios = [
  "I am very passionate about my city and I would love to show you around!",
  "I am a student and I love to travel. I am very friendly and I love meeting new people. I am very passionate about my city and I would love to show you around!",
  "I am a very nice person and I love meeting new people.",
  "Hello! I am a very friendly person and I love meeting new people. I am very passionate about my city and I would love to show you around!",
  "I am a very friendly person and I love meeting new people. ",
]

# give me an array of random people's face from the internet
faces = [
  "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg",
  "https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg",
  "https://img.freepik.com/free-photo/emotions-people-concept-headshot-serious-looking-handsome-man-with-beard-looking-confident-determined_1258-26730.jpg",
  "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19636.jpg",
  "https://img.freepik.com/free-photo/portrait-expressive-young-woman_1258-48167.jpg",
  "https://img.freepik.com/free-photo/happy-bearded-man-business-clothes-looking-camera_171337-11392.jpg",
  "https://img.freepik.com/free-photo/close-up-stylish-attractive-girl-with-hairbun-smiling-looking-hopeful_176420-25550.jpg",
  "https://img.freepik.com/free-photo/human-face-expressions-emotions-positive-joyful-young-beautiful-female-with-fair-straight-hair-casual-clothing_176420-15188.jpg",
  "https://img.freepik.com/free-photo/portrait-young-pretty-cheerful-girl-smiling_176420-9553.jpg",
  "https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg",
]

# give me a random array of activities with an icon inside the name

activities = [
 "🏀 Sports",
 "🎸 Music",
 "🍔 Food",
 "🎨 Art",
 "🏛 History",
 "🌳 Nature",
 "🎭 Culture",
 "🍸 Nightlife",
 "🛍 Shopping",
 "🏛 Architecture",
 "📸 Photography",
 "🐶 Animals",
  "🏛 Museums",
  "🏖 Beaches",
 "🥾 Hiking",
  "🚴‍♀️ Cycling",
  "🏛 Sightseeing",
  "🧘‍♀️ Relaxing",
  "💃 Dancing",
  "👩‍🍳 Cooking"

]


puts "Creating a new user..."

10.times do
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
    bio: bios[rand(0..4)],
    location: Faker::Address.city,
    interests: interests[rand(0..19)],
    price: Faker::Number.within(range: 10..50),
    start_date: Faker::Date.forward(days: 23),
    end_date: Faker::Date.forward(days: 30),
    activity: activities[rand(0..19)],
    user: user)
    file = URI.open(faces.delete(faces.sample))
    friend.image.attach(io: file, filename: "#{friend.first_name}.jpg", content_type: "image/jpg")
    results = Geocoder.search(friend.location)
      if results.present? && results.first.coordinates.present?
        friend.latitude = results.first.coordinates[0]
        friend.longitude = results.first.coordinates[1]
      end

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
    friend: friend,
    booking_status: Booking::STATUS.sample)
  end
end

puts "Created #{Booking.count} bookings"

puts "Creating reviews..."

# we need to create 1 review per user per friend per booking

booking = Booking.all
user = User.all
friend = Friend.all

10.times do
Review.create!(
  title: Faker::Lorem.sentence(word_count: 3),
  body: Faker::Lorem.paragraph(sentence_count: 5),
  rating: rand(1..5),
  user: user[rand(0..9)],
  friend: friend[rand(0..9)],
  booking: booking[rand(0..9)]
)
end

puts "Created #{Review.count} reviews"

puts "Finished!"
