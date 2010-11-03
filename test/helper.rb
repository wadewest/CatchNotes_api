require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'catch_notes'

class Test::Unit::TestCase
  
  def catch_info
    @@catch_info ||= {:username=>'foo@example.com', :password=>'foobar'}
  end
  
end
