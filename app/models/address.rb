class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :addresses, presence: true

  def pcode_address_name
    "〒" + self.postal_code + self.addresses + self.name
  end
end
