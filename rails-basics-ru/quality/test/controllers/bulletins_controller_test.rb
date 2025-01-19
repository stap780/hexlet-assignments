# frozen_string_literal: true

# BulletinsControllerTest < ActionController::TestCase
class BulletinsControllerTest < ActionController::TestCase
  setup do
    @bulletin_first = bulletins(:first)
    @bulletin_second = bulletins(:second)
  end

  test 'should get index' do
    get :index
    assert_response :success
    # assert_not_nil assigns(:bulletins)
  end

  test 'should show bulletin' do
    get :show, params: { id: @bulletin_first }
    assert_response :success
    # assert_not_nil assigns(:bulletin)
  end
end