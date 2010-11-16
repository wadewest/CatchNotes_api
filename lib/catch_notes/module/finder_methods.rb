module CatchNotes
  # Methods for finding resources
  module FinderMethods
    module ClassMethods
      # Returns all notes in the user's catch.com account
      #
      # ==== Example
      #   MyNoteClass.all
      def all
        res = get "/notes"
        build_note_array( res.parsed_response['notes'] ) if send(:ok?, res)
      end
  
      # Returns the note with the given +id+.  Will raise
      # a CatchNotes::NotFound exception if the note
      # doesn't exist.
      #
      # ==== Parameters
      # * +id+ - The id of the note to find
      #
      # ==== Example
      #   my_note = MyNoteClass.find!(1234)
      def find!(id)
        res = get "/notes/#{id}"
        send(:build_from_hash,res.parsed_response['notes'].first ) if send(:ok?,res)
      end

      # Returns the note with the given +id+.  Will return
      # nil if the note doesn't exist.
      #
      # ==== Parameters
      # * +id+ - The id of the note to find
      #
      # ==== Example
      #   my_note = MyNoteClass.find(1234)        
      def find(id)
        find!(id)
      rescue CatchNotes::NotFound
        nil
      end

      # Returns all notes that contain the given +tag_name+. Will
      # return an empty array if nothing is found, and raises an
      # exception if something goes wrong.
      #
      # ==== Parameters
      # * +tag_name+ - Then name of the tag to search for.
      #
      # ==== Example
      #   notes_about_blah = MyNoteClass.find_all_by_tag!('blah')
      def find_all_by_tag!( tag_name )
        res = get "/search?q=%23#{tag_name}"
        build_note_array( res.parsed_response['notes'] ) if send(:ok?, res)
      end

      # Returns all notes that contain the given +tag_name+. Will
      # return an empty array if nothing is found, and returns
      # nil if something goes wrong.
      #
      # ==== Parameters
      # * +tag_name+ - Then name of the tag to search for.
      #
      # ==== Example
      #   notes_about_blah = MyNoteClass.find_all_by_tag('blah')
      def find_all_by_tag( tag_name )
        find_all_by_tag!(tag_name)
      rescue
        []
      end
      
      def find_by_tag!( tag_name )
        find_all_by_tag!(tag_name).first
      end
      
      def find_by_tag( tag_name )
        find_all_by_tag!(tag_name).first
      rescue
        nil
      end
  
      def first
        all.first
      end
  
      def last
        all.last
      end

      def tags
        res = get "/tags"
        if send(:ok?, res)
          res.parsed_response['tags'].inject({}) do |hash, t|
            hash[t['name']] = Tagging.new t, self
            #hash[t['name'].to_sym] = Tagging.new t, self
            hash
          end
        end
      end
      
      private
      def build_note_array( notes )
        notes.map do |note|
          send :build_from_hash, note
        end
      end
    end
    
    def self.included(klass) #:nodoc:
      klass.extend ClassMethods
    end
  end
end