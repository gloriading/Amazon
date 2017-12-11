# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.destroy_all
Product.destroy_all

1000.times do
  Product.create(
    title: Faker::Seinfeld.quote,
    description: Faker::HitchhikersGuideToTheGalaxy.quote,
    price: rand(1..1000)
  )
end

products = Product.all

puts Cowsay.say("Created #{Product.count} products", :ghostbusters)


products.each do |product|
  rand(1..5).times.each do
    Review.create(
      rating: rand(1..5),
      body: Faker::TheFreshPrinceOfBelAir.quote,
      product: product
    )
  end
end

reviews = Review.all

puts Cowsay.say("Create #{reviews.count} reviews", :moose)
