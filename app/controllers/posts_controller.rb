class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :approve]
  def index
    @posts = Post.posts_by(current_user).page(params[:page]).per(10)
  end

  def approve
    authorize @post
    @post.approved!
    redirect_to root_path, notice: "The post has been approved."
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: "Your post was created"
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update(post_params)
    if @post.save
      redirect_to @post, notice: "Your post was updated"
    else
      render :edit, notice: 'Invalid update. Please try again.'
    end
  end

  def destroy
    @post.delete
    redirect_to posts_path, notice: 'Entry successfully deleted.'
  end

  private

      def post_params
        params.require(:post).permit(:date, :work_performed, :status, :user_id, :daily_hours)
      end

      def set_post
        @post = Post.find(params[:id])
      end

end
