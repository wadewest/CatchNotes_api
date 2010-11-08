module CatchNotes
  module Util
    
    module ClassMethods
      def stringify_keys (input_hash)
        input_hash.map{|k,v| [k.to_s, v]}.inject({}) do |hash, pair|
          hash[pair.first] = pair.last
          hash
        end
      end
      
      private
      def ok?(response)
        case response.code
        when 200 then true
        when 401 then raise CatchNotes::AuthError
        when 404 then raise CatchNotes::NotFound
        else raise CatchNotes::CatchNotesError
        end
      end
    end
    
    def self.included(klass)
      klass.extend ClassMethods
    end
    
  end
end

require 'catch_notes/errors'
require 'catch_notes/base'
require 'catch_notes/tagging'
