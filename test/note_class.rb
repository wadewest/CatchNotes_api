require 'catch_notes'
require 'faker'
class NoteClass < CatchNotes::Base
  base_uri "http://#{Faker::HOST}:#{Faker::PORT}"
  
  def self.good_user
    username "foo@example.com"
    password "foobar"
  end
  
  def self.bad_user
    username "bad@example.com"
    password "foobad"
  end
  
  good_user
  
end