require 'test_helper'

class PrestashopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prestashop_index_url
    assert_response :success
  end

end
