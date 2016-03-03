class UsersController < ApplicationController

  def index
    @users = User.where(admin: false)
  end

  def activity
    @users = User.where(admin: false)
  end

  def playback
    @user = User.find(params[:user_id])
    @nickname = @user.nickname
    # view activity for a specific assignment
    if params[:assignment_id] != NIL then
      @assignment = Assignment.find(params[:assignment_id])
      @activity_ids = Ahoy::Event.where(user_id: @user.id)
    else # view activity for all assignments
      @assignment = Assignment.all
      @activity_ids = Ahoy::Event.where(user_id: @user.id)
    end

  end

end
