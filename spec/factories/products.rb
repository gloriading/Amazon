FactoryBot.define do
  factory :product do
    # title "yeah"
    # description "ice cream is the best!"
    # price 200
    # user_id 132
    sequence(:title) { |n| "#{Faker::Cat.name} - #{n}" }
    description { Faker::Lorem.paragraph }
    price { 10 + rand(10000)}
    # user_id {User.all.sample.id}
    user_id 132
  end
end
