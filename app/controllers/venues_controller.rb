class VenuesController < ApplicationController
  def create
  	@venue = Venue.new(venue_params)
  	if @venue.save
  		flash.now[:success] = "Create Venue Successfully!"
  		redirect_to events_path
  	else
  		flash[:error] = "#{@venue.errors.full_messages.to_sentence}"
  		redirect_to new_venue_path
  	end
  end

private
  def venue_params
  	params.require(:venue).permit(:name, :full_address, :region_id)
  end
end
