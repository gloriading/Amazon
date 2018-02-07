class Product < ApplicationRecord
  has_many :faqs
  accepts_nested_attributes_for :faqs, reject_if: :all_blank, allow_destroy: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :likes, dependent: :destroy
  # has_many :users, through: :likes
  has_many :likers, through: :likes, source: :user

  has_many :favourites, dependent: :destroy
  # has_many :users, through: :favourites # or the following
  has_many :favouriters, through: :favourites, source: :user


  validates :title, presence: true, uniqueness: true

  validates :price, numericality: { greater_than: 0 }
  validates :sale_price, numericality: { less_than_or_equal_to: :price }
  validates :description, presence: true, length: { minimum: 10 }

  validate :reserved


  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  def on_sale?
    price > sale_price
  end
# ----------------------------------------------------------------------lab
# My solution: class method
  scope :search_it, -> (key) {
    where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  }

# Max: class method
  # def self.search_it(key)
  #   where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  # end

# from MAX ---------------------------------------------------------------lab
  # def self.search_it(word)
  #   # all of the titles that contain `word`
  #   titles = where 'title ILIKE ?', "%#{word}%"
  #
  #   # all of the descriptions that contain `word`
  #   descriptions = where 'description ILIKE ?', "%#{word}%"
  #
  #   # There may be duplicates (results that are in both `titles` and `descriptions`)
  #   # filter duplicates out of descriptions
  #   descriptions = descriptions.select do |elem|
  #     !titles.include? elem
  #   end
  #   # concat them together, with titles going first before descriptions
  #   titles+descriptions
  # end
# -------------------------------------------------------------------------
  def votes_result
    votes.where({ is_up: true }).count - votes.where({ is_up: false }).count
  end

  after_initialize :set_defaults, :sale_price_defaults
  after_initialize :titleize_title

  private

  def reserved
    if ( title.present? && title.downcase.include?('apple') ||
       title.present? && title.downcase.include?('microsoft') ||
       title.present? && title.downcase.include?('sony') )
      errors.add(:title, " is a reserved word...")
    end

  end

  def set_defaults
    self.price ||= 1.0   # if there's no value, set to 1
  end

  def sale_price_defaults
    self.sale_price ||= price
  end

  def capitalize
    self.title.try(:capitalize!)
    # self.title&.capitalize # not working
    # .try: when there's no title, we need to prevent it from crash
  end

  #
  # def capitalized_title
  #   self.title = title.split(" ").map {|word| word.capitalize || word}.join(" ")
  # end

  def titleize_title
     self.title = title.titleize if title.present?
  end
end

#---------------------------------------------------------------------------
