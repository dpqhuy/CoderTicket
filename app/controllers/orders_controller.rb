class OrdersController < ApplicationController
	def create
		@order = Order.create(email: order_params[:email], address: order_params[:address], phone_number: order_params[:phone_number])
		params[:order][:ticket_type].each_with_index do |type,index|
		  TicketItem.create(ticket_type_id: type, order_id: @order.id, quantity: params[:order][:quantity][index])
		end
		flash[:success] = "Buy Ticket Successfully"
		redirect_to root_path
	end
private
  def order_params
  	params.require(:order).permit(:ticket_type, :quantity, :email, :address, :phone_number)
  end
end
