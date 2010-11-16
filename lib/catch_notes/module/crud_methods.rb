module CatchNotes
  module CRUDMethods
    
    module ClassMethods
      private
      def build_from_hash(hash)
        send :new, hash
      end
    end
    
    def self.included(klass) #:nodoc:
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
end