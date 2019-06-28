class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3,
    too_short: "password has to be at least %{count} characters long" }
end
