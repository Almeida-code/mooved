class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association for bookings
  has_many :bookings, dependent: :destroy

  # Association for trucks if the user is a customer
  has_many :trucks, dependent: :destroy
end
