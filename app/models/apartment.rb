class Apartment < ApplicationRecord
  has_many :tenants, through: :leases
  has_many :leases
end
