class ListingsController < ApplicationController
  before_action :set_slider_values

  def index
    session[:postcode] = session[:postcode] || params[:postcode]

    listings  = params[:days_available].present? ? Listing.match_days(params[:days_available]) : Listing
    @q        = listings.ransack(params[:q])
    @listings = @q.result(distinct: true)

    if session[:postcode].present?
      # Lat, Lng should also be stored in session to save a lookup to google apis on each request.
      lat, lng = ConvertPostcode.call(session[:postcode])
      if lat.present? && lng.present?
        @listings = @listings.match_postcode(lat, lng)
      end
    end

    @listings = @listings.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
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
        @min_age, @max_age = 5, 10
      end
    end
end
