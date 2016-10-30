class TicketTypesController < ApplicationController
	def new
		@event = Event.find(params[:event_id])	
	end

	def create
  	@ticket_type = TicketType.new(ticket_type_params)
  	if @ticket_type.save
  		flash.now[:success] = "Create Ticket Type Successfully!"
  		redirect_to edit_event_path(ticket_type_params[:event_id])
  	else
  		flash[:error] = "#{@ticket_type.errors.full_messages.to_sentence}"
  		redirect_to new_event_ticket_type_path(ticket_type_params[:event_id])
  	end
  end

private
  def ticket_type_params
  	params.require(:ticket_type).permit(:event_id, :name, :price, :max_quantity)
  end
end
