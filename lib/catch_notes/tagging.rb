require 'httparty'
module CatchNotes
  class Tagging
    
    def initialize( attrs, creator )
      @attrs = attrs
      @creator = creator
    end
    
    def count
      @attrs['count']
    end
    
    def notes
      @creator.find_all_by_tag(@attr['name'])
    end
    
  end
end