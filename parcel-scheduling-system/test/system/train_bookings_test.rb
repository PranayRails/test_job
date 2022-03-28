require "application_system_test_case"

class TrainBookingsTest < ApplicationSystemTestCase
  setup do
    @train_booking = train_bookings(:one)
  end

  test "visiting the index" do
    visit train_bookings_url
    assert_selector "h1", text: "Train Bookings"
  end

  test "creating a Train booking" do
    visit train_bookings_url
    click_on "New Train Booking"

    click_on "Create Train booking"

    assert_text "Train booking was successfully created"
    click_on "Back"
  end

  test "updating a Train booking" do
    visit train_bookings_url
    click_on "Edit", match: :first

    click_on "Update Train booking"

    assert_text "Train booking was successfully updated"
    click_on "Back"
  end

  test "destroying a Train booking" do
    visit train_bookings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Train booking was successfully destroyed"
  end
end
