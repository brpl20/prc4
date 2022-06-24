require "test_helper"

class OfficeTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get office_types_index_url
    assert_response :success
  end
end
