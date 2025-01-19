# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'Post успешно создана'
      redirect_to @post
    else
      flash.now[:error] = 'Не удалось создать Post'
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'post успешно обновлена'
      redirect_to @post
    else
      flash.now[:error] = 'Не удалось обновить post'
      render :edit
    end
  end

  def destroy
    @post.destroy!
    flash[:success] = 'post успешно удалена'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary, :published)
  end
end
