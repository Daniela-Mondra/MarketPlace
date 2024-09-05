class Review < ApplicationRecord
  belongs_to :sale
  belongs_to :user

  validates :title, :content, :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
