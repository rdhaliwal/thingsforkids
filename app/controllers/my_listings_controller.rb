class MyListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @listings = current_user.listings.page(params[:page])
  end

  def pricing
    @listing = current_user.listings.create
  end

  private
    def choose_package
      redirect_to pricing_my_listings_path if params[:type].blank?
    end
end
