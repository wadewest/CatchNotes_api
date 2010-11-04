module CatchNotes
  
  # Generic Error
  class CatchNotesError < StandardError
  end
  
  # 401 response was returned
  class AuthError < CatchNotesError
  end
end