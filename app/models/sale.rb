class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :vinyl
  has_one :review
end
