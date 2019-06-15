class Service < ApplicationRecord
  belongs_to :car

  validates :title, presence: true
  validates :date, presence: true
  validates :car_id, presence: true
end
