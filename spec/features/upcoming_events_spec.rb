require 'rails_helper'

RSpec.feature "UpcomingEvents", type: :feature do

	before do
		@region = FactoryGirl.create(:region)
    	@venue = FactoryGirl.create(:venue, region: @region)
    	@category = FactoryGirl.create(:category)
  	end

	scenario "return [] when there is no events after current time" do
			@event = FactoryGirl.create(:event, venue: @venue, category: @category,
				starts_at: DateTime.parse('Thu, 24 Dec 2015, 8:00 PM+0700'),
			ends_at: DateTime.parse('Thu, 24 Dec 2015, 11:00 PM+0700'))
			expect(Event.upcoming).to eq []
	end	

	scenario "return [event] when event is after current time" do
		@event = FactoryGirl.create(:event, venue: @venue, 
			category: @category, 
			starts_at: DateTime.parse('Thu, 24 Dec 2016, 8:00 PM+0700'))
		expect(Event.upcoming).to eq [@event]
	end
end
