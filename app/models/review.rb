class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :loves, dependent: :destroy
  # has_many :users, through: :loves # or the following
  has_many :lovers, through: :loves, source: :user


  # validates :rating, presence: true, :inclusion => 1..5

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: ' must be between 1 to 5!'
  }

end
