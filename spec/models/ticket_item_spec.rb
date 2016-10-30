require 'rails_helper'

RSpec.describe TicketItem, type: :model do
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

  	scenario "Create ticket item successful" do
  		@ticket_type = FactoryGirl.create(:ticket_type, event: @event)
  		@order = Order.create
  		@ticket_item = TicketItem.new(quantity:4, ticket_type: @ticket_type, order: @order)
  		expect(@ticket_item.save).to eq true
  	end

  	scenario "Create ticket item without ticket_type" do
  		@order = Order.create
  		@ticket_item = TicketItem.new(quantity:4, order: @order)
  		expect(@ticket_item.save).to eq false
  	end

  	scenario "Create ticket item without order" do
  		@ticket_type = FactoryGirl.create(:ticket_type, event: @event)
  		@ticket_item = TicketItem.new(quantity:4, ticket_type: @ticket_type)
  		expect(@ticket_item.save).to eq false
  	end

  	scenario "Can not buy ticket with quantity larger than 10" do
  		@ticket_type = FactoryGirl.create(:ticket_type, event: @event)
  		@order = Order.create
  		expect{FactoryGirl.create(:ticket_item, quantity: 15, ticket_type: @ticket_type, order: @order)}.to raise_error ActiveRecord::RecordInvalid
  	end

  	scenario "Can not buy ticket with quantity larger than max_quantity of ticket_type" do
  		@ticket_type = FactoryGirl.create(:ticket_type, event: @event, max_quantity: 5)
  		@order = Order.create
  		expect{FactoryGirl.create(:ticket_item, quantity: 8, ticket_type: @ticket_type, order: @order)}.to raise_error ActiveRecord::RecordInvalid
  	end

    scenario "check validate quantity larger than max_quantity of ticket_type" do
      @ticket_type = FactoryGirl.create(:ticket_type, event: @event, max_quantity: 5)
      @order = Order.create
      @item = TicketItem.new(quantity: 8, ticket_type: @ticket_type, order: @order)
      expect(@item.valid?).to eq false
    end
end
