class User < ApplicationRecord
  has_many :locations, dependent: :destroy

  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product

  has_many :favourites, dependent: :destroy
  has_many :favourited_products, through: :favourites, source: :product

  has_many :loves, dependent: :destroy
  has_many :loved_reviews, through: :loves, source: :review

  has_many :votes, dependent: :destroy
  has_many :voted_products, through: :votes, source: :product

  has_many :review_votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :first_name, :last_name, presence: true



  geocoded_by :address
  after_validation :geocode

  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history, :finders]

  def full_name
    "#{first_name} #{last_name}"
  end

  before_create :generate_api_key

  def to_props
     ActiveRecord::Base.include_root_in_json = true
     json = to_json(
       only: [:id, :first_name, :last_name],
       methods: [:full_name]
     )
     ActiveRecord::Base.include_root_in_json = false
     json
   end

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(32)
      break unless User.exists?(api_key: api_key)
    end
  end

end
