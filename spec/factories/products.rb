FactoryBot.define do

  factory :user do
    first_name "John"
    last_name  "Doe"
    email "jd@gmail.com"
    password "123"
  end

  factory :product do
    # title "yeah"
    # description "ice cream is the best!"
    # price 200
    # user_id 132
    # user_id {User.sample.id}
    # user {User.order("RANDOM()").first}
    # association :user, factory: :user
    user
    sequence(:title) { |n| "#{Faker::Cat.name} - #{n}" }
    description { Faker::Lorem.paragraph }
    price { 10 + rand(1000)}

  end

  # factory :user do
  #   first_name "John"
  #   last_name  "Doe"
  #   email "jd@gmail.com"
  #
  # factory :user_with_product do
  #   after(:create) do |user|
  #     create(:product, user: user)
  #   end
  # end
  #
  # end
  #
  # factory :product do
  #     sequence(:title) { |n| "#{Faker::Cat.name} - #{n}" }
  #     description { Faker::Lorem.paragraph }
  #     price { 10 + rand(1000)}
  # end
  #

end
