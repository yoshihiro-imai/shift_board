class TweetsController < ApplicationController

  before_action :authenticate_user!, except: [:index]  


  def  index
    @tweet = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)

  end

  def new
   @tweet = Tweet.new
  end
  

  def create
   @tweet = Tweet.create(tweet_params)
   if @tweet.save
    redirect_to action: :create
   else
    render action: :new
   end
  end


  def show
    @tweet = Tweet.find(params[:id])
    @like = Like.new
  end

  def edit
    @tweet = Tweet.find(params[:id])

  end

  def update
   @tweet = Tweet.find(params[:id])
   @tweet.update(tweet_params)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  end


  private

  def tweet_params
    params.require(:tweet).permit(:title,:context).merge(user_id: current_user.id)
  end



end
