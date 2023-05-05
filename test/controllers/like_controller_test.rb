require 'test_helper'

class LikeControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get like_create_url
    assert_response :success
  end
end
