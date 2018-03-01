class MyListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listings = current_user.listings.page(params[:page])
  end
end
