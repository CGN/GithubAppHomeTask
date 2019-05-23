require 'github_client'

class HomeController < ApplicationController

  def index
    @user = User.find session['user_id'] unless session['user_id'].nil?
  end

  def callback
    github_client = GithubClient.new
    response = github_client.get_auth_token params[:code]
    if response['access_token'].nil?
      @error_message = response['error_description']
    else
      access_token = response['access_token']
      user_info = github_client.get_user access_token

      github_client.get_user_emails(access_token).each do |item|
        next unless item['primary']

        user = User.find_by_email item['email']
        user ||= User.new
        user.email = item['email']
        user.name = user_info['name']
        user.github_login = user_info['login']
        user.avatar_url = user_info['avatar_url']
        user.html_url = user_info['html_url']
        user.location = user_info['location']
        user.save

        session['user_id'] = user.id
        session['access_token'] = access_token
      end

      redirect_to root_path
    end
  end

  def logout
    session.delete('access_token')
    session.delete('user_id')
    redirect_to root_path
  end
end
