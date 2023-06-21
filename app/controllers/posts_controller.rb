class PostsController < ApplicationController
  before_action :require_login, only: [:new]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image]) if params[:post][:image].present?
    if @post.save
      redirect_to @post, notice: '投稿が作成されました'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_authorization
    unless @post.user == current_user
      redirect_to posts_path, alert: '権限がありません。'
    end
  end
end
