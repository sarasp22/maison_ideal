class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { tenant: 0, host: 1 }

  has_many :apartments, foreign_key: :host_id, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :payments, dependent: :destroy

  has_one_attached :avatar

  validates :role, inclusion: { in: roles.keys }

end
