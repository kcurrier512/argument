class UsersController < ApplicationController

  def index
    @users = User.where(admin: false)
  end

  def activity
    @users = User.where(admin: false)
  end

  def playback
    @user = User.find(params[:user_id])
    # view activity for a specific assignment
    if params[:assignment_id] != "0" then
      @assignment = Assignment.find(params[:assignment_id])
    else # view activity for all assignments
      @assignment = Assignment.all
    end
  end

end
