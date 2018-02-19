class HomeController < ApplicationController
  def index
    zip_code = params[:zip_code] || session[:zip_code]
    params[:q][:days_available_in] = "{#{params[:q][:days_available_in].join(',')}}" if params[:q].present? && params[:q][:days_available_in].present?
    @q = Listing.ransack(params[:q])

    if zip_code.present?
      session[:zip_code] = params[:zip_code] if session[:zip_code].blank?
      matched_listings = Listing.match_zip_code(zip_code)
      listings = @q.result(distinct: true)
      @listings = listings.where(id: matched_listings.ids).page(params[:page])
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
end
