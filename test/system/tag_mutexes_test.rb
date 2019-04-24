require "application_system_test_case"

class TagMutexesTest < ApplicationSystemTestCase
  setup do
    @tag_mutex = tag_mutexes(:one)
  end

  test "visiting the index" do
    visit tag_mutexes_url
    assert_selector "h1", text: "Tag Mutexes"
  end

  test "creating a Tag mutex" do
    visit tag_mutexes_url
    click_on "New Tag Mutex"

    click_on "Create Tag mutex"

    assert_text "Tag mutex was successfully created"
    click_on "Back"
  end

  test "updating a Tag mutex" do
    visit tag_mutexes_url
    click_on "Edit", match: :first

    click_on "Update Tag mutex"

    assert_text "Tag mutex was successfully updated"
    click_on "Back"
  end

  test "destroying a Tag mutex" do
    visit tag_mutexes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tag mutex was successfully destroyed"
  end
end
