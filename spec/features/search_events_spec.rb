require 'rails_helper'

RSpec.feature "SearchEvents", type: :feature do
	before do
		@region = FactoryGirl.create(:region)
    	@venue = FactoryGirl.create(:venue, region: @region)
    	@category = FactoryGirl.create(:category)

    	@event_no_match = FactoryGirl.create(:event,
			name: "No Match",
			venue: @venue, 
			category: @category, 
			starts_at: DateTime.parse('Thu, 24 Dec 2016, 8:00 PM+0700'))
  	end

	scenario "return [] when there is no events match the query" do
			expect(Event.search("event")).to eq []
	end	

	scenario "return [event] when event is matched to the query" do
		@event = FactoryGirl.create(:event,
			name: "Test Event",
			venue: @venue, 
			category: @category, 
			starts_at: DateTime.parse('Thu, 24 Dec 2016, 8:00 PM+0700'))
		expect(Event.search("event")).to eq [@event]
	end
end
