class Posts::CommentsController < Posts::ApplicationController
  before_action :resource_post
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = @resource_post.post_comments.all
  end

  def create
    @comment = @resource_post.post_comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@resource_post), notice: 'Comment was successfully created.'
    else
      render :new, notice: 'Comment was not created.', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@resource_post), notice: 'Comment was successfully updated.'
    else
      render :edit, notice: 'Comment was not updated.', status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(@resource_post), notice: 'Comment was successfully destroyed.'
    else
      render post_path(@resource_post), notice: 'Comment was not found destroy.'
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:body)
  end

  def set_comment
    @comment ||= PostComment.find(params[:id])
  end
end