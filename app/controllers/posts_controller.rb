class PostsController < ApplicationController
  #ゲストログイン時に使用できるアクションの指定
  before_action :guest_check, only: [:new, :show, :edit, :create, :destory, :update, :bookmarks]
  #未ログインでも一覧画面は見れるようにする
  skip_before_action :require_login, only: %i[index]
  #set_postの一文を定義している
  before_action :set_post, only: [:edit, :update, :destroy]
  #application_controllerにset_searchを記述したから必要なし
  #before_action :set_q, only: [:index, :new, :create, :edit, :update, :show]

  def index
    #投稿のデータを引っ張ってくる際に、関連付けされたモデルのデータも一緒に取得するために「includes(user)」を使う
    #@posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    #binding.pry
    @post.countries.build
    @post.whiskey_types.build
  end

  def create
    #current_user.posts.build=ログインしているユーザーの投稿を@postへ代入する
    @post = current_user.posts.build(post_params)
    #binding.pry      
    if @post.save
      redirect_to posts_path, success: t('posts.create.success')
    else
      #binding.pry
      flash.now[:danger] = t('posts.create.fail')
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    #詳細画面に新しいもの順にコメントが表示される
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('posts.update.success')
    else
      flash.now['danger'] = t('posts.update.fail')
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('posts.destroy.success')
  end

  def bookmarks
    #@bookmark_posts = current_user.bookmark_posts.includes(:user).order(created_at: :desc).page(params[:page])
    @q = current_user.bookmark_posts.ransack(params[:q])
    @bookmark_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_post
    #edit/update/destroyアクションで使う下記の一文をまとめて記載
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :post_image_cache, :price, :whiskey_brand, :country, :whiskey_type, countries_attributes: [:id, :name, :_destroy], whiskey_types_attributes: [:id, :name, :_destroy])
  end
end
