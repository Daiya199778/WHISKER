class Post < ApplicationRecord
  #Board モデルに、アップローダーの仕様を宣言しておく
  mount_uploader :post_image, PostImageUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  ###下記を入れたらエラーは消えたが、またエラーになる
  #has_many :bookmarks, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :price, presence: true
  validates :whiskey_brand, presence: true, length: { maximum: 255 }
  validates :countries, presence: true
  validates :whiskey_types, presence: true

  #post(投稿)は「原産国」「原材料」と1対多の関係
  has_many :countries, dependent: :destroy
  accepts_nested_attributes_for :countries, allow_destroy: true

  has_many :whiskey_types, dependent: :destroy
  accepts_nested_attributes_for :whiskey_types,  allow_destroy: true

end
