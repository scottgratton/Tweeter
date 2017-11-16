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
    @tweet_feed = following_tweets_temp.sort.reverse
    @users = User.all #this is what is used for who to follow
    @followers = []
    User.all.each do |user|
      if user.following.include?(current_user.id.to_i)
        @followers.push user
      end
    end

  end

  def show_user
    @user = User.find(params[:id])
    @tweet_feed = @user.tweets.sort.reverse
  end

  def now_following
    if current_user.following.exclude? params[:id].to_i
      current_user.following.push(params[:id].to_i)
      current_user.save
      # redirect_to show_user_path(id: params[:id])
    else
    end
    redirect_back(fallback_location: root_path)
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.all
  end

  def unfollow
    current_user.following.delete(params[:id].to_i) #no if statement needed. returns nil if no id found.
    current_user.save

    redirect_back(fallback_location: root_path)
  end

  def following
    @users = User.where(id: current_user.following)
  end

  def followers
    @users = []
    User.all.each do |user|
      if user.following.include?(current_user.id.to_i)
        @users.push user
      end
    end
      return @users
  end


end
