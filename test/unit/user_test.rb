require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Testing regular authentication
  test "Authentication mechanics" do
    # Can login using right account & password
    assert_equal(@admin, User.authenticate('admin','admin'))
    # Cannot login with wrong password
    assert_nil(User.authenticate('admin', 'anything'))
    # Cannot login with wrong user
    assert_nil(User.authenticate('not_a_user', 'admin'))
    # Cannot login with wrong user and password
    assert_nil(User.authenticate('not_a_user', 'anything'))
  end
  
  # Anonymous cannot login
  test "Anonymous is not allowed to login" do
    assert_nil(User.authenticate('anonymous', 'admin'))
  end
end