class OrdersController < ApplicationController
	def create
		@items = []
		@order = Order.create(email: order_params[:email], address: order_params[:address], phone_number: order_params[:phone_number])
		params[:order][:ticket_type].each_with_index do |type,index|
		  @item = TicketItem.new(ticket_type_id: type, order_id: @order.id, quantity: params[:order][:quantity][index])
		  if @item.valid?
		  	@items << @item
		  end
		end
		if params[:order][:ticket_type].count == @items.count
			@items.each do |item|
				item.save
			end
			flash[:success] = "Buy Ticket Successfully"
		else
			flash[:error] = "Quantity Is Larger Than Available"
		end
		redirect_to new_event_ticket_path(params[:event_id]) 
	end
private
  def order_params
  	params.require(:order).permit(:ticket_type, :quantity, :email, :address, :phone_number)
  end
end
