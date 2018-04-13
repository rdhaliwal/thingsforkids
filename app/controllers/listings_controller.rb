class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]
  before_action :set_listings, only: [:addresses]
  before_action :set_user_listing, only: [:edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_premium, only: [:edit]

  def index
    session[:postcode] = session[:postcode] || params[:postcode]
    listings  = params[:days_available].present? ? Listing.match_days(params[:days_available]) : Listing
    listings  = listings.match_age(params[:age][:min_age], params[:age][:max_age]) if params[:age].present?
    @q        = listings.ransack(params[:q])
    @listings = @q.result(distinct: true).active_listings

    if session[:postcode].present?
      session[:lat], session[:lng] = ConvertPostcode.call(session[:postcode]) if session[:lat].blank?
      if session[:lat].present? && session[:lng].present?
        @listings = @listings.match_postcode(session[:lat], session[:lng])
      end
    end

    @listings = @listings.sort_listings.page(params[:page])

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
    if @listing.update(listing_params)
      if params[:token].present?
        result, card = AddCreditCard.call!(current_user, params[:token])
        CreateListingSubscription.call(current_user, @listing, card)
      end
      redirect_to @listing, notice: "Congratulations! You have upgraded the listing to premium."
    else
      render :edit
    end
  end

  def addresses
    respond_to do |format|
      format.json
    end
  end

  def draw
    @listings = Listing.where(id: params[:listings].first.split(','))

    respond_to do |format|
      format.js
    end
  end

  private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_listings
      return @listings = Listing.near([params[:lat], params[:lng]], 10) if params[:lat] && params[:lng]
      @listings = Listing.where(id: params[:listings].first.split(','))
    end

    def set_user_listing
      @listing = current_user.listings.find_by(id: params[:id])
      redirect_to listing_path(params[:id]), alert: "You are not allowed to perform this action." if @listing.blank?
    end

    def listing_params
      params.require(:listing).permit(:facbook_url, :instagram_url, :listing_type, :status, images: [])
    end

    def check_premium
      redirect_to @listing, alert: "Listing has already been upgraded." if @listing.premium?
    end
end
