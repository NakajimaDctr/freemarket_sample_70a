class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_duration
  # belongs_to_active_hash :shipping_payer
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_from_area
  has_many   :images, dependent: :destroy

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true

end
