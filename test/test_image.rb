require 'helper'
require 'note_class'

class TestImage < Test::Unit::TestCase
  should 'be able to download the image from the fake server' do
    res = NoteClass.get '/catch_image.png'
    assert res.code == 200
    assert_equal res.body, File.read(File.join(TEST_DIR, "catch_logo.png"))
  end

  should 'be able to get the url of an attached image' do
    note = NoteClass.find_by_tag 'image'
    assert_instance_of NoteClass, note
    assert note.respond_to? :attached_image?
    assert note.attached_image?
    assert_equal note.attached_image.url, "http://#{Faker::HOST}:#{Faker::PORT}/catch_image.png"
  end

  should 'be able to get the data of an attached image' do
    note = NoteClass.find_by_tag 'image'
    assert_instance_of NoteClass, note
    assert note.respond_to? :attached_image?
    assert note.attached_image?
    assert_equal note.attached_image.data, File.read(File.join(TEST_DIR, "catch_logo.png"))
  end
end
