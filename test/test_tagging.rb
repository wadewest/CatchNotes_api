require 'helper'
require 'note_class'

class TestTagging < Test::Unit::TestCase
  def setup
    NoteClass.good_user
  end
  
  should "be able to get a list of tags" do
    assert_instance_of Hash, NoteClass.tags
  end
  
  should "be able to find all notes with a given tag" do
    notes = NoteClass.find_all_by_tag 'blah'
    assert_instance_of Array, notes
    assert_instance_of NoteClass, notes.first
    assert_equal 'blah', notes.first.tags.first
  end
  
  should "be able to find the first note with a given tag" do
    note = NoteClass.find_by_tag 'blah'
    assert_instance_of NoteClass, note
  end
  
end