require 'test_helper'

class EmailSettingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get email_setting_index_url
    assert_response :success
  end

end
