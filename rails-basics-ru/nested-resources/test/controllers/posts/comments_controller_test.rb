require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @post = posts(:without_comments)
    @comment = post_comments(:one)

    @attrs = {
      body: Faker::Lorem.sentence
    }
  end

  test 'should create comments' do
    post post_comments_url(@post), params: { post_comment: @attrs }
    comment = PostComment.find_by @attrs

    assert { comment }
    assert_redirected_to post_url(@post)
  end

  test 'should get edit comments' do
    get edit_post_comment_url(@post, @comment)

    assert_response :success
  end

  test 'should update comments' do
    patch post_comment_url(@post, @comment), params: { post_comment: @attrs }
    @comment.reload

    assert { @comment.body == @attrs[:body] }
    assert_redirected_to post_url(@post)
  end

  test 'should delete comments' do
    delete post_comment_url(@post, @comment)

    assert { !PostComment.exists?(@comment.id) }
    assert_redirected_to post_url(@post)
  end
end