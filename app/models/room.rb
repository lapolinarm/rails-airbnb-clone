class Room < ApplicationRecord
  # Association
  # Una habitación pertenece a un usuario y puede tener muchas reservas
  belongs_to :user
  has_many :bookings

  # Validations
  validates :name, :description, :address, :capacity_max, :price, presence: true
end
