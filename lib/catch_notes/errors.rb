module CatchNotes
  
  # Generic Error
  class CatchNotesError < StandardError
  end
  
  # 401 response was returned
  class AuthError < CatchNotesError
  end
  
  # 404 response was returned
  class NotFound < CatchNotesError
  end
end