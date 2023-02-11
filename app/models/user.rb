class User < ApplicationRecord
  authenticates_with_sorcery!
  #Userモデルに、postモデルとの関連付けを追加
  has_many :posts, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
    #passwordの長さを５文字以上に設定
    #if: 以降=> 登録したユーザがパスワード以外のプロフィール項目を更新したいとき、パスワードの入力を省略できるようになる。
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
    #password, confirmation => passwordというDBに存在しない仮想的な属性(virtual attributes)が追加される。という意味。
    #if: 以降=> 登録したユーザがパスワード以外のプロフィール項目を更新したいとき、パスワードの入力を省略できるようになる。
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
    #uniqueness: true => メールアドレスの重複を防ぐ ＆ presence: true => 空白入力を防ぐ
end
