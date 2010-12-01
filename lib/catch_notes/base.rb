require 'httparty'

module CatchNotes
  class Base
    
    attr_reader :id, :created_at, :modified_at, :source, :source_url,
      :children, :user_name, :user_id, :tags
    attr_accessor :text, :summary, :reminder_at, :location
    
    include HTTParty
    base_uri "https://api.catch.com/v1"
    
    include AuthItems
    include FinderMethods
    include CRUDMethods
    include ImageSupport
    include Util
    
  end
end
