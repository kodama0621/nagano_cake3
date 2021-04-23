class Item < ApplicationRecord
  has_many :cart_items
  belongs_to :genre
  has_many :order_items
  attachment :image

  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def taxprice
    tax = 1.1
    (price * tax).floor
  end
end
