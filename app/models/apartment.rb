class Apartment < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :title, :description, :address, :price, presence: true
end
