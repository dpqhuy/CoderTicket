require 'rails_helper'

RSpec.describe TicketTypesController, type: :controller do
	describe 'routing' do
    it 'routes GET /events/1/ticket_types/new to TicketTypesController#new' do
      expect(get: '/events/1/ticket_types/new').to route_to(controller: 'ticket_types', action: 'new', event_id: '1')
    end
  end
end
