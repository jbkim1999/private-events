class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :attend]

  def index
    @event = Event.upcoming.order(:event_date) # using scope
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params) # not events, created_events
    if @event.save
      flash[:success] = "Great! Your event has been created!"
      redirect_to @event
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new
    end
  end
  
  def attend
    @event = Event.find(params[:id])
    
    if current_user == @event.creator
      flash[:error] = "You are the creator of this event!"
      redirect_to @event
    elsif @event.attendees.include? current_user
      flash[:error] = "You have already joined the event!"
      redirect_to @event
    elsif @event.event_date < DateTime.current
      flash[:error] = "This event has already been closed... We're sorry..."
      redirect_to @event
    else
      event_attending = EventAttending.new(attendee_id: current_user.id, attended_event_id: @event.id)
      event_attending.save
      redirect_to @event
    end
  end
  
  private 
  def event_params # strong parameter
    params.require(:event).permit(:event_date, :title, :details)
  end
end
