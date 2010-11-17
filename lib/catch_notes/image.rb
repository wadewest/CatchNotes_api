module CatchNotes
  class Image
    
    attr_accessor :url, :data
    
    def initialize(opts = {})
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
    
    # Sets the url of the image to +new_url+
    #
    # ==== Parameters
    # * +new_url+ - A URL that points to an image.  The data attribute will be set to nil when this is set.
    #
    # ==== Example
    #   image = CatchNotes::Image.new
    #   image.url = 'http://example.com/hosted/image.jpg'
    def url=(new_url)
      @data = nil
      @url = new_url
    end
    
    # Returns the raw data of the image.  If there is no data, it will be generated from the image at +url+ if it is set.
    def data
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
    
    # Set the raw data of the image to +new_data+.  The url attribute will be set to nil when this is set.
    #
    # ==== Parameters
    # * +new_data+ - The data of an image.
    #
    # ==== Example
    #   image = CatchNotes::Image.new
    #   image.data = File.read('tmp/some_uploaded_image.jpg')
    def data=(new_data)
      @url = nil
      @data = new_data
    end
    
    def destroy! #:nodoc:
    end
    
    def destroy #:nodoc:
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