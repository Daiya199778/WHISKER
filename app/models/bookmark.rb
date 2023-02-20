class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  #uniqueness: { scope: :post_id }を付けないとブックマークを外しても初めにブックマークをつけた関係性が残り、ブックマークが外せなくなる。
  validates :user_id, uniqueness: { scope: :post_id }
end
