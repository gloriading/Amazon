class Faq < ApplicationRecord
  belongs_to :product
  validates :question, :answer, presence: true
end
