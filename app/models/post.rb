class Post < ApplicationRecord
  #Board モデルに、アップローダーの仕様を宣言しておく
  mount_uploader :post_image, PostImageUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  ###下記を入れたらエラーは消えたが、またエラーになる
  #has_many :bookmarks, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :whiskey_brand, presence: true, length: { maximum: 255 }
  validates :countries, presence: true
  validates :whiskey_types, presence: true

  #post(投稿)は「原産国」「原材料」と1対多の関係
  has_many :countries, dependent: :destroy
  accepts_nested_attributes_for :countries, allow_destroy: true

  has_many :whiskey_types, dependent: :destroy
  accepts_nested_attributes_for :whiskey_types,  allow_destroy: true

  #一番最後に「_prefix: true」=接頭辞をつけることでenum間での重複（others）があったとしてもエラーにならない！！
  enum country: { スコットランド: 0, アイルランド: 1, アメリカ: 2, カナダ: 3, 日本: 4, 台湾: 5, インド: 6, その他: 7 }, _prefix: true
  enum whiskey_type: { モルト: 0, グレーン: 1, ブレンデッド: 2, バーボン: 3, ライ: 4, コーン: 5, その他: 6 }, _prefix: true
end
