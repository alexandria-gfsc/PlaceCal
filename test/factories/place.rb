FactoryBot.define do
  factory(:place) do
    name 'Hulme Community Garden Centre'
    short_description nil
    accessibility_info nil
    booking_info nil
    logo nil
    opening_times nil
    phone nil
    status nil
    after(:build) do |place|
      place.turfs << FactoryBot.create(:turf)
    end
  end
end
