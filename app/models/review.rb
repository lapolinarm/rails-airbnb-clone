class Review < ApplicationRecord
  # Association
  # Un comentario pertenece a una reserva
  belongs_to :booking

  # Validations
  validates :comment, :rating, presence: true
end
