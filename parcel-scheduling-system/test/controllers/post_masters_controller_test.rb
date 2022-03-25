require "test_helper"

class PostMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_master = post_masters(:one)
  end

  test "should get index" do
    get post_masters_url
    assert_response :success
  end

  test "should get new" do
    get new_post_master_url
    assert_response :success
  end

  test "should create post_master" do
    assert_difference('PostMaster.count') do
      post post_masters_url, params: { post_master: {  } }
    end

    assert_redirected_to post_master_url(PostMaster.last)
  end

  test "should show post_master" do
    get post_master_url(@post_master)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_master_url(@post_master)
    assert_response :success
  end

  test "should update post_master" do
    patch post_master_url(@post_master), params: { post_master: {  } }
    assert_redirected_to post_master_url(@post_master)
  end

  test "should destroy post_master" do
    assert_difference('PostMaster.count', -1) do
      delete post_master_url(@post_master)
    end

    assert_redirected_to post_masters_url
  end
end
