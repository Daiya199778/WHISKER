class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:edit, :update, :destroy, :show]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path, success: t('posts.update.success')
    else
      flash.now['danger'] = t('posts.update.fail')
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to admin_posts_path, success: t('posts.destroy.success')
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :post_image_cache, :price, :whiskey_brand, countries_attributes: [:id, :name], whiskey_types_attributes: [:id, :name])
  end
end
