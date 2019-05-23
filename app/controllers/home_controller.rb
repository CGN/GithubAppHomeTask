class HomeController < ApplicationController

  def index
  end

  def callback
    @error_message = 'invalid code'
  end
end
