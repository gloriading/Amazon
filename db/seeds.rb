PASSWORD = '123'

Review.destroy_all
Product.destroy_all
User.destroy_all
Tag.destroy_all
Location.destroy_all

# -------------------------------------------------------------------------
super_user = User.create(
  first_name: 'Gloria',
  last_name: 'Ding',
  email: 'gd@gmail.com',
  password: PASSWORD,
  is_admin: true
)

20.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all
puts Cowsay.say("Create #{users.count} users", :tux)
# -------------------------------------------------------------------------

 15.times do
   Location.create(
     ip: Array.new(4){rand(256)}.join('.'),
     user: users.sample
   )
 end

 locations = Location.all
 puts Cowsay.say("Created #{locations.count} locations", :stegosaurus)

# -------------------------------------------------------------------------
100.times do
  Product.create(
    title: Faker::Dessert.variety,
    description: Faker::Lorem.paragraphs,
    price: rand(10..500),
    user: users.sample
  )
end

products = Product.all

puts Cowsay.say("Created #{Product.count} products", :ghostbusters)

# TAG--------------------------------------------------------------------------
['Arts', 'Sports', 'News', 'Cats', 'Cartoons', 'Lifestyle', 'Tech'].each do |tag_name|
  Tag.create(name: tag_name)
end

tags = Tag.all
puts Cowsay.say("Created #{Tag.count} tags", :cow)
# -------------------------------------------------------------------------
products.each do |product|
  rand(1..5).times.each do
    Review.create(
      rating: rand(1..5),
      body: Faker::Simpsons.quote,
      product: product,
      user: users.sample,
      is_hidden: false
    )
  end
end

reviews = Review.all

puts Cowsay.say("Create #{reviews.count} reviews", :moose)

# -------------------------------------------------------------------------

puts "Login as admin with #{super_user.email} and password of '#{PASSWORD}'!"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?