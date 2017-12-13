class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validate :reserved
  validates(
      :title,
      presence: true,
      uniqueness: {case_sensitive: false}
    )
  validates :price, numericality: {greater_than: 0}
  validates :description, presence: true, length: {minimum: 10}

# ----------------------------------------------------------------------lab
# My solution: class method
  # scope :search, -> (key) {
  #   where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  # }

# Max: class method
  # def self.search(key)
  #   where("title ILIKE '%#{key}%' or description ILIKE '%#{key}%'")
  # end

# from MAX ---------------------------------------------------------------lab
  def self.search(word)
    # all of the titles that contain `word`
    titles = where 'title ILIKE ?', "%#{word}%"

    # all of the descriptions that contain `word`
    descriptions = where 'description ILIKE ?', "%#{word}%"

    # There may be duplicates (results that are in both `titles` and `descriptions`)
    # filter duplicates out of descriptions
    descriptions = descriptions.select do |elem|
      !titles.include? elem
    end
    # concat them together, with titles going first before descriptions
    titles+descriptions
  end
# -------------------------------------------------------------------------

  after_initialize :set_defaults
  before_save :capitalize


  private

  def reserved
    if ( title.present? && title.downcase.include?('apple') ||
       title.present? && title.downcase.include?('microsoft') ||
       title.present? && title.downcase.include?('sony') )
      errors.add(:title, " is a reserved word...")
    end

  end

  def set_defaults
    self.price ||= 1
    # if there's no value, set to 1
  end

  def capitalize
    title.capitalize!
  end

end
