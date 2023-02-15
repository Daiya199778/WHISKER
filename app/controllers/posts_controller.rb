class PostsController < ApplicationController
  def index
    #投稿のデータを引っ張ってくる際に、関連付けされたモデルのデータも一緒に取得するために「includes(user)」を使う
    @posts = Post.all.includes(:user).order(created_at: :desc)
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
      flash.now['danger'] = t('posts.create.fail')
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :price, :whiskey_brand, countries_attributes: [:id, :name, :_destroy], whiskey_types_attributes: [:id, :name, :_destroy])
  end
end
