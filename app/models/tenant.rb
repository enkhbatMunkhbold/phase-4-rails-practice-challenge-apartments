class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :age, numericality: { minimum: 18 }
  has_many :leases
  has_many :apartment, through: :leases
end
