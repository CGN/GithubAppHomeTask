require 'github_client'

class HomeController < ApplicationController

  def index
    if !session['access_token'].nil?
      @user_info = GithubClient.new.get_user session['access_token']
    end
  end

  def callback
    response = GithubClient.new.get_auth_token params[:code]
    if response['access_token'].nil?
      @error_message = response['error_description']
    else
      session['access_token'] = response['access_token']
      redirect_to root_path
    end
  end

  def logout
    session.delete('access_token')
    redirect_to root_path
  end
end
