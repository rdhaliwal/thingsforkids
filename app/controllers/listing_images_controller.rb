class ListingImagesController < ApplicationController
  before_action :set_image

  def destroy
    if @image.present?
      @image.delete
      flash[:notice] = "Image Removed successfully."
    else
      flash[:alert] = "Image not found."
    end
    redirect_to my_listing_build_listing_path(@listing.id, :images_form, type: @listing.listing_type)
  end

  private

    def set_image
      @listing = Listing.find_by(id: params[:listing_id])
      return redirect_to my_listing_build_listing_path(@listing.id, :images_form, type: @listing.listing_type), alert: "Listing not found" if @listing.blank?
      @image = @listing.images.find_by(id: params[:id])
    end
end
