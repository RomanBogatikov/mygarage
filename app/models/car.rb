class Car < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy

  validates :year, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :user_id, presence: true
end
