class EpicenterController < ApplicationController
  before_action :authenticate_user!

  def feed
    following_tweets_temp = []
    Tweet.all.each do |tweet|
      if tweet.user_id == current_user.id ||
         current_user.following.include?(tweet.user_id)
      following_tweets_temp.push tweet
      end
    end
    @following_tweets = following_tweets_temp.sort.reverse
    @users = User.all
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    if current_user.following.exclude? params[:id].to_i
      current_user.following.push(params[:id].to_i)
      current_user.save
      # redirect_to show_user_path(id: params[:id])
    else
      redirect_to feed_path
    end
    redirect_to feed_path

  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to feed_path
  end
end
