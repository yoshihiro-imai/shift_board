class TweetsController < ApplicationController

  before_action :authenticate_user!, except: [:index]  
  before_action :exist_tweet?,only:[:show,:edit,:update,:destroy]
  before_action :set_item,only:[:show,:edit,:update,:destroy]

  def  index
    @tweet = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(6)

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
    @like = Like.new
  end

  def edit
   if @tweet.user.id != current_user.id
    redirect_to action: :index
   end
  end

  def update
   @tweet.update(tweet_params)
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end


  private

  def tweet_params
    params.require(:tweet).permit(:title,:context,:image).merge(user_id: current_user.id)
  end

def set_item
  @tweet = Tweet.find(params[:id])
end

def exist_tweet?
  unless Tweet.find_by(id: params[:id]) 
   redirect_to action: :index
  end
end


end
