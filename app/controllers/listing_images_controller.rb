class ListingImagesController < ApplicationController
  before_action :set_image

  def destroy
    if @image.present?
      @image.delete
      flash[:notice] = "Image Removed successfully."
    else
      flash[:alert] = "Image not found."
    end
    redirect_to redirect_route
  end

  private

    def set_image
      @listing = Listing.find_by(id: params[:listing_id])
      return redirect_to my_listings_path, alert: "Listing not found" if @listing.blank?
      @image = @listing.images.find_by(id: params[:id])
    end

    def redirect_route
      return edit_listing_path(@listing) if params[:update] == "true"
      edit_my_listing_path(@listing)
    end
end
