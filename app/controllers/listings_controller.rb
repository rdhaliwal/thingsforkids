class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]
  before_action :authenticate_user!, only: [:edit, :update, :create]
  before_action :set_user_listing, only: [:edit, :update]
  before_action :check_premium, only: [:edit]

  def index
    if params[:postcode].present? && session[:postcode] != params[:postcode]
      session[:postcode] = params[:postcode]
      session[:lat], session[:lng] = ConvertPostcode.call(session[:postcode])
    end

    @listings = SearchListings.call(params, session)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @message = Message.new
  end

  def create
    listing = current_user.listings.create(listing_type: params[:listing_type], status: 'basic')
    redirect_to my_listing_build_listing_path(listing.id, :basic_info, type: listing.listing_type)
  end

  def edit
  end

  def update
    begin
      if @listing.update(listing_params)
        if params[:token].present?
          result, card = AddCreditCard.call!(current_user, params[:token])
          CreateListingSubscription.call(current_user, @listing, card, params[:coupon])
        end
        redirect_to @listing, notice: "Congratulations! You have upgraded the listing to premium."
      else
        render :edit
      end
    rescue Exception => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_user_listing
      @listing = current_user.listings.find_by(id: params[:id])
      redirect_to listing_path(params[:id]), alert: "You are not allowed to perform this action." if @listing.blank?
    end

    def listing_params
      params.require(:listing).permit(:facbook_url, :instagram_url, :listing_type, :status, :description, :logo, images: [])
    end

    def check_premium
      redirect_to @listing, alert: "Listing has already been upgraded." if @listing.premium?
    end
end
