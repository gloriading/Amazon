class Product < ApplicationRecord
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

  def on_sale?
    price > sale_price
  end
# ----------------------------------------------------------------------lab
# My solution: class method
  scope :search, -> (key) {
    where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  }

# Max: class method
  # def self.search(key)
  #   where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  # end

# from MAX ---------------------------------------------------------------lab
  # def self.search(word)
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
