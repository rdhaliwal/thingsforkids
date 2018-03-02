class ListingsController < ApplicationController
  before_action :set_slider_values
  before_action :set_listing, only: [:show]

  def index
    session[:postcode] = session[:postcode] || params[:postcode]

    listings  = params[:days_available].present? ? Listing.match_days(params[:days_available]) : Listing
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

  def addresses
    listings = Listing.where(id: params[:listings].first.split(',')).collect(&:full_address) if params[:listings].present?
    respond_to do |format|
      format.json { render json: { listings: listings }}
    end
  end

  private
    def set_slider_values
      if params[:age_range].present?
        @min_age, @max_age = params[:age_range].split(',')
      else
        @min_age, @max_age = 0, 10
      end
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end
end
