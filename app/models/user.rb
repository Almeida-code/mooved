class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :email_uniquness_check, on: :create

  # Association for bookings
  has_many :bookings, dependent: :destroy

  # Association for trucks if the user is a companys
  has_many :trucks, dependent: :destroy

  private

  def email_uniquness_check
    if User.exists?(email: email)
      errors.add(:email,)
    end
  end
end
