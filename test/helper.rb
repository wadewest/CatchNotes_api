require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'faker'

TEST_DIR = File.dirname(__FILE__)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'catch_notes'

class Test::Unit::TestCase
  
end
