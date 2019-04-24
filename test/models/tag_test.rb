require 'test_helper'

class TagTest < ActiveSupport::TestCase

   test "tags need titles" do
     tag = Tag.new
     assert_not tag.save, "Saved a tag without a title"
   end

   test "tags code set from title if missing" do
     tag = Tag.new(title: "Tag C")
     tag.save
     assert_equal "tag_c", tag.code, "Tags generate code based on title"
   end

   test "tags code not overwritten" do
     tag = Tag.new(title: "Tag D", code: "Some& Invalid Code")
     assert_not tag.save, "Tags codes must be word characters"
   end

   test "immutable tags cannot be updated" do
     tag = Tag.new(title: "Tag E", immutable: true)
     tag.save
     assert_raise(RuntimeError){ tag.update }
   end

   test "immutable tags cannot be destroyed" do
     tag = Tag.new(title: "Tag F", immutable: true)
     tag.save
     assert_raise(RuntimeError){ tag.destroy }
   end

end
