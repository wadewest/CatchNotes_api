require 'catch_notes'
class NoteClass < CatchNotes::Base
  username ENV['CATCH_USER']
  password ENV['CATCH_PASS']
end