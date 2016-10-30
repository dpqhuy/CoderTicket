require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
	describe 'routing' do
    	it 'routes POST /events/1/orders to OrdersController#new' do
	      expect(post: '/events/1/orders').to route_to(controller: 'orders', action: 'create', event_id: '1')
	    end
  	end
end
