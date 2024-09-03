class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # Association
  # Un usuario puede tener muchas habitaciones, reservas y comentarios
  has_many :rooms, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  # Validations
  validates :first_name, :last_name, :email, presence: true
end
