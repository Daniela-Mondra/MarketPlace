class Vinyl < ApplicationRecord
  belongs_to :user
  has_many :sales, dependent: :destroy
  has_one_attached :photo
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, inclusion: { in: %w[Rock Pop Electronic Jazz Hip-hop] }
  include PgSearch::Model
    pg_search_scope :search_by_title_and_artist,
      against: [ :title, :artist ],
      using: {
        tsearch: { prefix: true }
      }
end
