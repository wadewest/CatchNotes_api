require 'httparty'
module CatchNotes
  class Tagging
    include HTTParty
    
    def initialize( attrs, auth )
      @attrs = attrs
      self.class.basic_auth auth[:username], auth[:password]
    end
    
    def count
      @attrs['count']
    end
    
    def notes
      res = self.class.get "https://api.catch.com/v1/search?q=%23#{@attrs['name']}"
      if self.class.send(:ok?, res)
        res.parsed_response['notes'].map do |n|
          Base.new(n)
        end
      end
    end
    
    include Util
  end
end