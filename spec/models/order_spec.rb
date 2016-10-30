require 'rails_helper'

RSpec.describe Order, type: :model do
	before do
		@region = FactoryGirl.create(:region)
    	@venue = FactoryGirl.create(:venue, region: @region)
    	@category = FactoryGirl.create(:category)

    	@event = FactoryGirl.create(:event,
			name: "Event",
			venue: @venue, 
			category: @category, 
			starts_at: DateTime.parse('Thu, 24 Dec 2016, 8:00 PM+0700'))
  	end

  	scenario "create order failed" do
  		@order = Order.create()
  		
  		
  		expect(@order.save).to eq false
  	end

  	scenario "create order successfully" do
  		@order = Order.new(email: "a@b.com", phone_number: "0192312")
  		expect(@order.save).to eq true
  	end
end
