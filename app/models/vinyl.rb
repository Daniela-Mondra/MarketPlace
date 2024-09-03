class Vinyl < ApplicationRecord
  belongs_to :user
  has_many :sales
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, inclusion: { in: %w[Rock Pop Electronic Jazz Hip-hop] }
end
