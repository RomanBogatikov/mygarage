class User < ApplicationRecord
  has_secure_password
# dependent: :destroy is needed to destroy user's cars when the user is destroyed
  has_many :cars, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
end
