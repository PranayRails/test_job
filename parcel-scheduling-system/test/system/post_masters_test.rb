require "application_system_test_case"

class PostMastersTest < ApplicationSystemTestCase
  setup do
    @post_master = post_masters(:one)
  end

  test "visiting the index" do
    visit post_masters_url
    assert_selector "h1", text: "Post Masters"
  end

  test "creating a Post master" do
    visit post_masters_url
    click_on "New Post Master"

    click_on "Create Post master"

    assert_text "Post master was successfully created"
    click_on "Back"
  end

  test "updating a Post master" do
    visit post_masters_url
    click_on "Edit", match: :first

    click_on "Update Post master"

    assert_text "Post master was successfully updated"
    click_on "Back"
  end

  test "destroying a Post master" do
    visit post_masters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post master was successfully destroyed"
  end
end
