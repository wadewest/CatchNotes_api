require 'catch_notes'
class NoteClass < CatchNotes::Base
  
  def self.good_user
    username ENV['CATCH_USER']
    password ENV['CATCH_PASS']
  end
  
  def self.bad_user
    username "foo@example.com"
    password "foobar"
  end
  
  good_user
  
end