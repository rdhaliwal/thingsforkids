class MyListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show]

  def index
    @listings = current_user.listings.page(params[:page])
  end

  def show
  end

  private
    def set_listing
      @listing = current_user.listings.find(params[:id])
    end
end
