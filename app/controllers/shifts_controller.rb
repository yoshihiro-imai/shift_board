class ShiftsController < ApplicationController

  def new
    @shifts = ShiftCollection.new
  end

  def create
    @shifts = ShiftCollection.new(users_params)
    if @shifts.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def users_params
      params.require(:shifts).merge(user_id: current_user.id)
  end

end