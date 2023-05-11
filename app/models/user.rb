class User < ApplicationRecord
  authenticates_with_sorcery!
  #google認証のための外部認証の関連付け
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  mount_uploader :avatar, AvatarUploader
  #Userモデルに、postモデルとの関連付けを追加
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  #その代わりに、「through: :bookmarks, source: :post」の「source: :post」を追加するのことによって、postモデルのことですよ！と明示している！
  has_many :bookmark_posts, through: :bookmarks, source: :post

  validates :name, presence: true
  #uniqueness: true => メールアドレスの重複を防ぐ ＆ presence: true => 空白入力を防ぐ
  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  #passwordの長さを５文字以上に設定
  #if: 以降=> 登録したユーザがパスワード以外のプロフィール項目を更新したいとき、パスワードの入力を省略できるようになる。
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  #password, confirmation => passwordというDBに存在しない仮想的な属性(virtual attributes)が追加される。という意味。
  #if: 以降=> 登録したユーザがパスワード以外のプロフィール項目を更新したいとき、パスワードの入力を省略できるようになる。
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }

  enum role: { general: 0, admin: 1 }

  #ユーザーのコメントであるかを判定するメソッドを user モデルに追加する
  def own?(object)
    id == object.user_id
  end

  #bookmarkメソッド
  #掲示板の情報のレコードが引数boardに格納されbookmarks_boardsに<<演算子で追加されている。
  #<<は指定されたオブジェクトの末尾に破壊的に追加できるメソッド。
  #強制的に追加されて保存もされているのでsaveメソッドなどは必要ない。
  #bookmarks_posts << postはbookmarks.create!(post_id: post.id)と同様の処理がされている。
  def bookmark(post)
    bookmark_posts << post
  end

  #unbookmarkメソッド
  #bookmarks_postsからpostの引数に入っている投稿idが入ったレコードを探し出して削除（delete)するメソッド。
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  #bookmark?メソッド
  #bookmarks_postsにpostの引数に入っている投稿idが含まれているレコードがあるかどうか判定するメソッド。
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

end
