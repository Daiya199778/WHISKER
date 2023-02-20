class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  #uniqueness: { scope: :board_id }を付けないとブックマークを外しても初めにブックマークをつけた関係性が残り、ブックマークが外せなくなる。
  validates :user_id, uniqueness: { scope: :board_id }
end
