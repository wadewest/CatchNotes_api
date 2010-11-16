module CatchNotes
  module Util
    
    module ClassMethods
      # Takes a hash and returns a new hash with all keys
      # transformed into strings.
      # 
      # ==== Parameters
      # * +input_hash+ - The hash to stringify
      #
      # ==== Example
      #   stringify_keys( :hello => "world", 1 => 2) # => {'hello' => 'world', '1' => 2}
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
    
    def self.included(klass) #:nodoc:
      klass.extend ClassMethods
    end
    
  end
end

Dir["#{File.dirname(__FILE__)}/catch_notes/module/*.rb"].each do |lib|
  require lib
end
require 'catch_notes/errors'
require 'catch_notes/base'
require 'catch_notes/tagging'
