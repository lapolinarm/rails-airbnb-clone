class Room < ApplicationRecord
  # Association
  # Una habitación pertenece a un usuario y puede tener muchas reservas
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  # Validations
  validates :name, :description, :address, :capacity_max, :price, presence: true

   # Instance Methods
  def average_rating
    reviews.average(:rating).to_f.round(2)
  end
end
