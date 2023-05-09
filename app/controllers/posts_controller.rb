class PostsController < ApplicationController
  #ゲストログイン時に使用できるアクションの指定
  before_action :guest_check, only: [:bookmarks]
  #未ログインでも一覧画面は見れるようにする
  skip_before_action :require_login, only: %i[index]
  #set_postの一文を定義している
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @post.countries.build
    @post.whiskey_types.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('posts.create.success')
    else
      flash.now[:danger] = t('posts.create.fail')
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
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
    @q = current_user.bookmark_posts.ransack(params[:q])
    @bookmark_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :post_image_cache, :price, :whiskey_brand, countries_attributes: [:id, :name], whiskey_types_attributes: [:id, :name])
  end
end
