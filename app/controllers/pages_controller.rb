class PagesController < ApplicationController

  def home
    @friend = Friend.where(user: current_user).first
  end
end
