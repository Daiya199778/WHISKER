class WhiskeyType < ApplicationRecord
  belongs_to :Post
  validates :name, presence: true
end
