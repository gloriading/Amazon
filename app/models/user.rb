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

  validates :email,
    presence: true,
    uniqueness: true,
    format: VALID_EMAIL_REGEX,
    unless: :from_oauth?

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :from_oauth?

  serialize :oauth_raw_data

  def self.create_from_oauth(oauth_data)
    first_name, last_name = oauth_data["info"]["name"]&.split || [oauth_data["info"]["nickname"]]

    User.create(
      uid: oauth_data["uid"],
      provider: oauth_data["provider"],
      first_name: first_name,
      last_name: last_name,
      oauth_token: oauth_data["credentials"]["token"],
      oauth_raw_data: oauth_data,
      password: SecureRandom.hex(32)
    )
  end

  def from_oauth?
    uid.present? && provider.present?
  end

  def self.find_by_oauth(oauth_data)
    self.find_by(
      provider: oauth_data["provider"],
      uid: oauth_data["uid"]
    )
  end

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
