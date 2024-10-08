class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vynils
  has_many :sales
  has_many :reviews, dependent: :destroy

  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
end
