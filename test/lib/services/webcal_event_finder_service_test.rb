require 'test_helper'
require 'services/webcal_event_finder_service'
class WebcalEventFinderServiceTest < Minitest::Test
  def setup
    url = 'webcal://api.eventcalendarapp.com/widget-subscription/9891/0352139f-4e45-49e9-b48b-54c8a73ecadd'
    url.sub!('webcal', 'http') # to make it work when stubbing

    stub_request(:get, url)
      .to_return(status: 200, body: mock_ics_data, headers: { 'Content-Type' => 'text/calendar' })

    @event_finder_service = WebcalEventFinderService.new(url)
  end

  def test_search_for_breakfast_event
    target_date = Date.new(2025, 5, 28)
    breakfast = 8 # am
    event = @event_finder_service.search_event(target_date, breakfast)

    assert event.found?
    assert_equal 'Breakfast', event.meal_time
    assert_equal 'Rollin in Daisies', event.summary
    assert_equal '08:00 AM', event.start
    assert_equal '12:00 PM', event.end
    assert_equal 'Handmade Gluten Free Cinnamon rolls', event.description
  end

  def test_search_for_lunch_event
    target_date = Date.new(2025, 5, 28)
    lunch = 12 # pm
    event = @event_finder_service.search_event(target_date, lunch)

    assert event.found?
    assert_equal 'Lunch', event.meal_time
    assert_equal 'Temaki Tornado', event.summary
    assert_equal '12:00 PM', event.start
    assert_equal '04:00 PM', event.end
    assert_equal 'Food truck specializing in handrolls and fresh fish!', event.description
  end

  def test_search_for_event_not_found
    target_date = Date.new(2025, 4, 16)
    breakfast = 8 # am
    event = @event_finder_service.search_event(target_date, breakfast)

    refute event.found?
    assert_nil event.meal_time
    assert_nil event.summary
    assert_nil event.start
    assert_nil event.end
    assert_nil event.description
  end

  private

  def mock_ics_data
    load_fixture 'data.ics'
  end
end
