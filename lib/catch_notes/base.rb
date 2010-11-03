require 'httparty'
require 'json'
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
        def all
          res = get "/notes"
          if res.code == 200
            JSON.parse(res.body)['notes'].map do |note|
              send :new, note
            end
          end
        end
    
        def find(id)
          res = get "/notes/#{id}"
          if res.code == 200
            send :new, JSON.parse(res.body)['notes'].first
          end
        end
    
        def first
          all.first
        end
    
        def last
          all.last
        end
      end
      
      def self.included(klass)
        klass.extend ClassMethods
      end
    end
    
    def self.stringigy_keys (input_hash)
      input_hash.map{|k,v| [k.to_s, v]}.inject({}) do |hash, pair|
        hash[pair.first] = pair.last
        hash
      end
    end
    
    def initialize(attributes)
      @attr = self.class.stringigy_keys attributes
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
    
    def save
      false
    end
    
    def destroy
      false
    end
    
    include AuthItems
    include FinderMethods
    
  end
end
