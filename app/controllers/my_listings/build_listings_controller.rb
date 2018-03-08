class MyListings::BuildListingsController < Wicked::WizardController
  before_action :set_listing, only: [:show, :update]
  prepend_before_action :set_steps, only: [:show, :update]
  before_action :setup_wizard, only: [:show, :update]

  def show
    render_wizard
  end

  def update
    set_status
    @listing.update_attributes(listing_params)
    if params[:token].present? && step == steps.last
      result, card = AddCreditCard.call!(current_user, params[:token])
      CreateListingSubscription.call(current_user, @listing, card)
    end
    params[:type] = @listing.listing_type
    render_wizard(@listing, {}, { type: @listing.listing_type })
  end

  private

    def set_steps
      if params[:type].blank? && params[:listing].blank?
        return redirect_to pricing_my_listings_path, alert: "Please select a package."
      elsif params[:type] == "free"
        self.steps = [:basic_info, :amenities]
      elsif params[:type] == "premium"
        self.steps = [:basic_info, :amenities, :images_form, :price]
      end
    end

    def set_listing
      @listing = current_user.listings.find(params[:my_listing_id])
    end

    def listing_params
      params.require(:listing).permit(:business_name, :manager_name, :manager_job_title, :description, :address, :city,
                                      :state, :postcode, :website, :activity_type, :email, :phone, :logo, :price, :indoors,
                                      :outdoors, :highchairs, :disability_access, :parking, :free_trial, :undercover,
                                      :bbq, :toilets, :baby_change_room, :listing_type, :facbook_url, :instagram_url,
                                      :status, :parties, :short_description, images: [], days_available: [])
    end

    def set_status
      case step
      when :basic_info
        status = 'basic'
      when :amenities
        status = 'amenities'
      when :images_form
        status = 'images'
      when :price
        status = 'price'
      end
      params[:listing][:status] = step == steps.last ? 'active' : status
    end

    def finish_wizard_path
      listing_path @listing
    end
end
