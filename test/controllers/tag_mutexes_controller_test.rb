require 'test_helper'

class TagMutexesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_mutex = tag_mutexes(:one)
  end

  test "should get index" do
    get tag_mutexes_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_mutex_url
    assert_response :success
  end

  test "should create tag_mutex" do
    assert_difference('TagMutex.count') do
      post tag_mutexes_url, params: { tag_mutex: {  } }
    end

    assert_redirected_to tag_mutex_url(TagMutex.last)
  end

  test "should show tag_mutex" do
    get tag_mutex_url(@tag_mutex)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_mutex_url(@tag_mutex)
    assert_response :success
  end

  test "should update tag_mutex" do
    patch tag_mutex_url(@tag_mutex), params: { tag_mutex: {  } }
    assert_redirected_to tag_mutex_url(@tag_mutex)
  end

  test "should destroy tag_mutex" do
    assert_difference('TagMutex.count', -1) do
      delete tag_mutex_url(@tag_mutex)
    end

    assert_redirected_to tag_mutexes_url
  end
end
