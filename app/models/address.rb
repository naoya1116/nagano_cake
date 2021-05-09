class Address < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :customer

  def full_deliveries
    self.postal_code + self.address + self.name
  end

end
