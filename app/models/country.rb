class Country < ApplicationRecord
  belongs_to :post, optional: true

  validates :name, presence: true
end
