class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @event = @user.created_events # association reference
    @attended_event = @user.attended_events # association reference
  end
end
