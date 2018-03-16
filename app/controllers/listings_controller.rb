class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]
  before_action :authenticate_user!, only: [:create]

  def index
    session[:postcode] = session[:postcode] || params[:postcode]
    listings  = params[:days_available].present? ? Listing.match_days(params[:days_available]) : Listing
    listings  = listings.match_age(params[:age][:min_age], params[:age][:max_age]) if params[:age].present?
    @q        = listings.ransack(params[:q])
    @listings = @q.result(distinct: true)

    if session[:postcode].present?
      session[:lat], session[:lng] = ConvertPostcode.call(session[:postcode]) if session[:lat].blank?
      if session[:lat].present? && session[:lng].present?
        @listings = @listings.match_postcode(session[:lat], session[:lng])
      end
    end

    @listings = @listings.page(params[:page])

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

  def addresses
    listings = Listing.where(id: params[:listings].first.split(',')).collect(&:full_address) if params[:listings].present?
    respond_to do |format|
      format.json { render json: { listings: listings }}
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end
end
