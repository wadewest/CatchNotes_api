module CatchNotes
  class Image
    
    attr_accessor :url, :data
    
    def initialize(opts)
      @attr = opts
      @url = nil
      @data = nil
      if opts[:url]
        init_from_url
      elsif opts[:file]
        init_from_file
      elsif opts[:data]
        init_from_data
      end
    end
    
    def url=(new_url)
      @data = nil
      @url = new_url
    end
    
    def data #:nodoc:
      if @data.nil? && !@url.nil?
        res = HTTParty.get @url
        if res.code == 200
          @data = res.body
        else
          raise
        end
      end
      @data
    end
    
    def data=(new_data)
      @url = nil
      @data = new_data
    end
    
    def destroy!
    end
    
    def destroy
      destroy!
    rescue
      false
    end
    
    private
    def init_from_file
      @data = File.read(@attr[:file])
    end
    
    def init_from_url
      @url = @attr[:url]
    end
    
    def init_from_data
      @data = @attr[:data]
    end
    
  end
end