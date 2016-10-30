class EventsController < ApplicationController
	before_action :check_event_changing_permission, only: [:edit]
 
  def index
  	if params[:search]
  		@events = Event.search(params[:search])
  	else
    	@events = Event.upcoming
	end
  end

  def show
    @event = Event.find(params[:id])
  end

  def publish
  	@event = Event.find(params[:id])
  	unless @event.ticket_types.empty?
  		@event.update_attribute(:published_at, DateTime.now)
  		flash[:error] = ""
  	else
  		flash[:error] = "Can not publish event doesn't have any ticket types"
  	end
  	
  	redirect_to mine_events_path
  end

  def mine
  	@events = Event.where("user_id = ?", current_user.id)
  end

  def new
  	@event = Event.new
  end

  def edit
  	@event = Event.find(params[:id])
  end

  def create
  	@event = Event.new(event_params)
  	@event.user_id = current_user.id
  	if event_params[:starts_at]
  		@event.starts_at = DateTime.strptime(event_params[:starts_at], "%Y-%m-%d")
  	end
  	if event_params[:ends_at]
  		@event.ends_at = DateTime.strptime(event_params[:ends_at], "%Y-%m-%d")
  	end
  	if @event.save
  		flash.now[:success] = "Create Event Successfully!"
  		redirect_to mine_events_path
  	else
  		flash[:error] = "#{@event.errors.full_messages.to_sentence}"
  		redirect_to new_event_path
  	end
  end

  def update
  	@event = Event.find(params[:id])
  	if event_params[:starts_at]
  		event_params[:starts_at] = DateTime.strptime(event_params[:starts_at], "%Y-%m-%d")
  	end
  	if event_params[:ends_at]
  		event_params[:ends_at] = DateTime.strptime(event_params[:ends_at], "%Y-%m-%d")
  	end
  	if @event.update_attributes(event_params)
  		flash.now[:success] = "Update Event Successfully!"
  		redirect_to mine_events_path
  	else
  		flash[:error] = "#{@event.errors.full_messages.to_sentence}"
  		redirect_to edit_event_path
  	end
  end

private
  def event_params
  	params.require(:event).permit(:id, :name, :extended_html_description, :hero_image_url, :starts_at, :ends_at, :venue_id, :category_id)
  end

  def check_event_changing_permission
    @event = Event.find(params[:id])
    if @event.user_id != current_user.id
      flash[:error] = "You dont have permission to edit this event!"
      redirect_to root_path
    end
  end

end
