require 'sinatra/base'
require 'json'
module Faker
  
  HOST = 'localhost'
  PORT = 7000
  
  class Server < Sinatra::Base
    
    use Rack::Auth::Basic do |username, password|
      [username, password] == ['foo@example.com', 'foobar']
    end
    
    helpers do
      def build_note(opts = {})
        opts = {
          'id' => rand(332422),
          'text' => "A Note for testing."
        }.merge(opts)
        {
          "browser_url" => "https:\/\/catch.com\/m\/BPTEv\/6Jmd9SKkP0f",
          "public_url"  => nil,
          "source"      => "Catch.com",
          "text"        => opts['text'],
          "created_at"  => "2010-11-02T15:57:46.919Z",
          "tags"        => [],
          "modified_at" => "2010-11-03T13:47:28.674Z",
          "source_url"  => "https:\/\/catch.com\/",
          "children"    => 0,
          "reminder_at" => nil,
          "location"    => nil,
          "summary"     => opts['text'].lines.first,
          "id"          => opts['id'],
          "user"        => {
                             "user_name"  => "joe_user",
                             "id"         => 7923442
                          }
        }
      end
    end
    
    # For getting all notes
    get "/notes" do
      content_type 'application/json', :charset => 'utf-8'
      JSON.generate({
        'notes' => [
          build_note('text'=>'Test note one'),
          build_note('text'=>'Test note two'),
          build_note('text'=>'Test note three'),
          build_note('text'=>'Test note four')
        ]
      })
    end
  
    # For getting a note by id
    get %r{/notes/(\d+)} do |id|
      halt 404 if id.to_i == 13
      content_type 'application/json', :charset => 'utf-8'
      JSON.generate({
        'notes' => [build_note('id'=> id.to_i)]
      })
    end
  
    # For posting new notes
    post "/notes" do
      content_type 'application/json', :charset => 'utf-8'
      JSON.generate({
        'notes' => [
          build_note('text' => params[:text])
        ]
      })
    end  
    
    # For posting updates to notes
    post %r{/notes/(\d+)} do |id|
      content_type 'application/json', :charset => 'utf-8'
      JSON.generate({
        'notes' => [
          build_note('text' => params[:text], 'id' => params[:id].to_i)
        ]
      })
    end
  end
  
  Thread.new do
    Server.run! :host => HOST, :port => PORT.to_i
  end
  
end