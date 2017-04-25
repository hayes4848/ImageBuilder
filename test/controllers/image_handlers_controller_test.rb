require 'test_helper'

class ImageHandlersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_handler = image_handlers(:one)
  end

  test "should get index" do
    get image_handlers_url
    assert_response :success
  end

  test "should get new" do
    get new_image_handler_url
    assert_response :success
  end

  test "should create image_handler" do
    assert_difference('ImageHandler.count') do
      post image_handlers_url, params: { image_handler: {  } }
    end

    assert_redirected_to image_handler_url(ImageHandler.last)
  end

  test "should show image_handler" do
    get image_handler_url(@image_handler)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_handler_url(@image_handler)
    assert_response :success
  end

  test "should update image_handler" do
    patch image_handler_url(@image_handler), params: { image_handler: {  } }
    assert_redirected_to image_handler_url(@image_handler)
  end

  test "should destroy image_handler" do
    assert_difference('ImageHandler.count', -1) do
      delete image_handler_url(@image_handler)
    end

    assert_redirected_to image_handlers_url
  end
end
