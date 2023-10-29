require "test_helper"

class ReservationTest < ActiveSupport::TestCase
    test "end_date should not be before start_date" do
      reservation = Reservation.new(start_date: Date.today, end_date: Date.yesterday)
      assert_not reservation.valid?
    end
  
    test "should not save reservation if dates overlap with another reservation" do
      listening = Listening.create(available_beds: 3, price: 100, description: "Lorem ipsum dolor
      sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
      velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
      has_wifi: true, welcome_message: "Welcome to our place") # создание жилья
      reservation1 = Reservation.create(listening: listening, start_date: Date.tomorrow, end_date: Date.tomorrow + 3.days)
      reservation2 = Reservation.new(listening: listening, start_date: Date.tomorrow + 1.day, end_date: Date.tomorrow + 4.days)
      assert_not reservation2.save
    end
end
