class Booking < ApplicationRecord
  #Association
  # Una reserva pertenece a un usuario y a una habitación y puede tener muchos comentarios
  belongs_to :user
  belongs_to :room
  has_many :reviews

  # Validations
  validates :date_start, :date_finish, presence: true
end
