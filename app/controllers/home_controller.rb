class HomeController < ApplicationController
  before_action :set_slider_values

  def index
    postcode = params[:postcode] || session[:postcode]
    @q = Listing.ransack(params[:q])

    if postcode.present?
      session[:postcode] = params[:postcode] if session[:postcode].blank?
      lat, lng = ConvertPostcode.call(postcode)
      if lat.present? && lng.present?
        matched_listings = Listing.match_days(params[:days_available]).ids if params[:days_available].present?
        @listings = @q.result(distinct: true).where(id: matched_listings) if matched_listings.present?
        @listings = @q.result(distinct: true) unless matched_listings.present?
        @listings = @listings.match_postcode(lat, lng).page(params[:page])
      end
    end

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
