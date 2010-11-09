require 'httparty'
module CatchNotes
  class Base
    
    attr_reader :id, :created_at, :modified_at, :source, :source_url,
      :children, :user_name, :user_id
    attr_accessor :text, :summary, :tags, :reminder_at, :location
    
    include HTTParty
    base_uri "https://api.catch.com/v1"
    
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
      
      def self.included(klass)
        klass.extend ClassMethods
      end
    end
    
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

        def find_all_by_tag!( tag_name )
          res = get "/search?q=%23#{tag_name}"
          build_note_array( res.parsed_response['notes'] ) if send(:ok?, res)
        end

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
      
      def self.included(klass)
        klass.extend ClassMethods
      end
    end
    
    module CRUDMethods
      
      module ClassMethods
        private
        def build_from_hash(hash)
          send :new, hash
        end
      end
      
      def self.included(klass)
        klass.extend ClassMethods
      end
      
      def initialize(attributes)
        @attr = self.class.send :stringify_keys, attributes
        @id = @attr['id']
        @created_at = @attr['created_at']
        @modified_at = @attr['modified_at']
        @source = @attr['source']
        @source_url = @attr['source_url']
        @children = @attr['children']
        @text = @attr['text']
        @summary = @attr['summary']
        @tags = @attr['tags']
        @reminder_at = @attr['reminder_at']
        @location = @attr['location']
        unless @attr['user'].nil?
          @user_name = @attr['user']['user_name']
          @user_id = @attr['user']['id']
        end
      end
    
      def save!
        res = if new_record?
          self.class.send(:post, "/notes", :body => post_body)
        else
          self.class.send(:post, "/notes/#{self.id}", :body => post_body)
        end
        if self.class.send(:ok?, res)
          rebuild res.parsed_response['notes'].first
        end
        true
      end
      
      def save
        save!
      rescue
        false
      end
    
      def destroy!
        raise CatchNotes::NotFound if new_record? # can't delete an unsaved note
        res = self.class.send(:delete, "/notes/#{self.id}")
        self.class.send(:ok?, res)
      end
    
      def destroy
        destroy!
      rescue
        false
      end
      
      def new_record?
        i = self.send :id
        i.nil?
      end
    
      private
      def post_body
        {
          'text' => send(:text)
        }.map{|k,v| "#{URI.encode(k)}=#{URI.encode(v)}"}.join("&")
      end
      
      def rebuild(attrs)
        initialize(attrs)
      end

        
    end
    
    include AuthItems
    include FinderMethods
    include CRUDMethods
    include Util
    
  end
end
