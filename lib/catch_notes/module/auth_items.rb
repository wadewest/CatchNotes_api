module CatchNotes
  # Methods for Authenication
  module AuthItems
    module ClassMethods
      def username( username )
        send(:basic_auth, username, get_auth[:password] || '')
      end
  
      def password( password )
        send(:basic_auth, get_auth[:username] || '', password)
      end
    
      def valid_username?
        username = get_auth[:username]
        !(username.nil? || username == '')
      end
    
      def valid_password?
        password = get_auth[:password]
        !(password.nil? || password == '')
      end
      
      private
      def get_auth
        send(:default_options)[:basic_auth] || {}
      end
    end
    
    def self.included(klass) #:nodoc:
      klass.extend ClassMethods
    end
  end
end