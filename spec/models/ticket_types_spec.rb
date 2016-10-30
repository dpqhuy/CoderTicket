require 'rails_helper'

RSpec.describe "TicketTypes", type: :model do
	before do
		@region = FactoryGirl.create(:region)
    	@venue = FactoryGirl.create(:venue, region: @region)
    	@category = FactoryGirl.create(:category)

    	@event = FactoryGirl.create(:event,
			name: "No Match",
			venue: @venue, 
			category: @category, 
			starts_at: DateTime.parse('Thu, 24 Dec 2016, 8:00 PM+0700'))
  	end

	scenario "can not create two ticket types with same event, price, name and max_quantity" do
			FactoryGirl.create(:ticket_type, event: @event)
			expect{FactoryGirl.create(:ticket_type, event: @event)}.to raise_error ActiveRecord::RecordInvalid
	end	

	scenario "can create two ticket types with same event, price, name but different max_quantity" do
			FactoryGirl.create(:ticket_type, event: @event)
			expect{FactoryGirl.create(:ticket_type, event: @event, max_quantity: 50)}.to_not raise_error ActiveRecord::RecordInvalid
	end	
end
