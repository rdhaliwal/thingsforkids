class MyListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show]
  before_action :choose_package, only: :new

  def index
    @listings = current_user.listings.page(params[:page])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save

      if params[:token].present?
        result, card = AddCreditCard.call!(current_user, params[:token])
        CreateListingSubscription.call(current_user, @listing, card)
      end

      redirect_to listing_path(@listing)
    else
      params[:type] = @listing.listing_type
      render :new
    end
  end

  def pricing
  end

  private
    def set_listing
      @listing = current_user.listings.find(params[:id])
    end

    def choose_package
      redirect_to pricing_my_listings_path if params[:type].blank?
    end

    def listing_params
      params.require(:listing).permit(:business_name, :manager_name, :manager_job_title, :description, :address, :city,
                                      :state, :postcode, :website, :activity_type, :email, :phone, :logo, :price, :indoors,
                                      :outdoors, :highchairs, :disability_access, :parking, :free_trial, :undercover,
                                      :bbq, :toilets, :baby_change_room, :listing_type, :facbook_url, :instagram_url,
                                      :parties, :short_description, images: [], days_available: [])
    end
end
