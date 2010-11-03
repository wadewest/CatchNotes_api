require 'helper'

class TestCatchnotes < Test::Unit::TestCase
  
  should "have valid login info" do
    assert_instance_of Hash, catch_info
    assert_not_nil catch_info[:username], "Need a username to connect"
    assert_not_nil catch_info[:password], "Need a password to connect"
    assert_not_equal '', catch_info[:username], "Need a username to connect"
    assert_not_equal '', catch_info[:password], "Need a password to connect"
  end
  
end
