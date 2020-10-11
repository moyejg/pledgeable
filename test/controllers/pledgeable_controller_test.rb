require 'test_helper'

class PledgeableControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pledgeable_home_url
    assert_response :success
  end

end
