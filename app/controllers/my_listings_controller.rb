class MyListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:edit, :update, :destroy]

  def index
    @listings = current_user.listings.active.page(params[:page]).per(8)
  end

  def edit
    params[:type] = @listing.listing_type
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Changes were successfully saved."
    else
      render :edit
    end
  end

  def destroy
    if @listing.premium?
      subscription_id = @listing.subscription_id
      RemoveSubscription.call(subscription_id) if subscription_id.present?
    end

    if @listing.destroy
      redirect_to my_listings_path, notice: "Listing was successfully removed."
    end
  end

  private
    def set_listing
      @listing = current_user.listings.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:business_name, :manager_name, :manager_job_title, :description, :address, :city,
                                      :state, :postcode, :website, :activity_type, :email, :phone, :logo, :indoors,
                                      :outdoors, :highchairs, :disability_access, :parking, :free_trial, :undercover,
                                      :bbq, :toilets, :baby_change_room, :listing_type, :facbook_url, :instagram_url,
                                      :status, :parties, :short_description, :min_age, :max_age, :opens_at, :closes_at,
                                      images: [], days_available: [])
    end
end
