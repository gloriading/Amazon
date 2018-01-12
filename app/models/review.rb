class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :loves, dependent: :destroy
  # has_many :users, through: :loves # or the following
  has_many :lovers, through: :loves, source: :user

  has_many :review_votes, dependent: :destroy
  has_many :review_voters, through: :review_votes, source: :user

  def review_votes_result
    review_votes.where({ is_up: true }).count - review_votes.where({ is_up: false }).count
  end
# review.review_votes_result => integer

  # def review_votes_count
  #   self.review_votes.count
  # end
  # validates :rating, presence: true, :inclusion => 1..5

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: ' must be between 1 to 5!'
  }

end
