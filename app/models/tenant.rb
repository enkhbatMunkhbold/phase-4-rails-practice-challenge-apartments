class Tenant < ApplicationRecord
  validates :name, presence: true
  has_many :leases
  has_many :apartment, through: :leases
end
