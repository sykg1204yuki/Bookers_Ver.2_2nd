class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    #current_user.active_relationships.create(follower_id: params[:user_id])
    current_user.follow(params[:user_id])
      #↑↑を記述の場合は、user.rbにてfollowメソッドを定義
    redirect_to request.referer

  end

  def destroy
    #current_user.active_relationships.find_by(params[:user_id]).destroy
    current_user.unfollow(params[:user_id])
      #↑↑を記述の場合は、user.rbにてunfollowメソッドを定義
    redirect_to request.referer

  end


  #Follow Users一覧作成のためのメソッド
  def followings
    user = User.find(params[:user_id])
    #byebug
    @users = user.followings

  end

  #Follower Users一覧作成のためのメソッド
  def followers
    user = User.find(params[:user_id])
    @users = user.followers

  end


end
