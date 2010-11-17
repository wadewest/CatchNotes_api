module CatchNotes
  
  # Adds support for working with an image attached to a note.
  module ImageSupport
    
    # Returns true if the note has an attached image.
    def image?
      @attr['media'] && @attr['media'].size > 0
    end
    
    # Returns the images attached to the note
    def image
      if image?
        @image ||= Image.new(:url => @attr['media'].first['src'], :note => self)
      else
        nil
      end
    end
    
    # Sets the image attached to the note, and uploads the image.
    #
    # ==== Parameters
    # * +image_object_or_file_path_or_url+ - Can be one of three things: a CatchNotes::Image instance, a path to a file on the local filesystem, or a url to an image.  Passing in nil will delete the current attachment.
    def image=(image_object_or_file_path_or_url)
      
    end
  end
end