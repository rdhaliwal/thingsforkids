ActiveAdmin.register Listing do
  permit_params :activity_type, :min_age, :max_age, :business_name, :description, :logo, :user_id, :short_description,
                :facbook_url, :instagram_url, :manager_name, :manager_job_title, :phone, :email, :website, :price,
                :postcode, :please_bring, :indoors, :outdoors, :parties, :disability_access, :parking, :free_trial,
                :undercover, :bbq, :toilets, :highchairs, :baby_change_room, :opens_at, :closes_at, :address, :city, :state,
                days_available: [], images: []

  form do |f|
    f.inputs :business_name
    f.inputs :min_age
    f.inputs :max_age
    f.inputs :activity_type
    f.inputs :description
    f.inputs :short_description
    f.inputs do
      f.input :days_available, as: :check_boxes, collection: Listing::WEEK_DAYS
    end
    f.inputs "Add logo" do
      f.file_field :logo unless f.object.logo.attached?
      f.input :logo, hint: image_tag(f.object.logo, size: "75x75") if f.object.logo.attached?
    end
    f.inputs :facbook_url
    f.inputs :instagram_url
    f.inputs :manager_name
    f.inputs :manager_job_title
    f.inputs :phone
    f.inputs :email
    f.inputs :website
    f.inputs :price
    f.inputs :postcode
    f.inputs :please_bring
    f.inputs :indoors
    f.inputs :outdoors
    f.inputs :parties
    f.inputs :disability_access
    f.inputs :parking
    f.inputs :free_trial
    f.inputs :undercover
    f.inputs :bbq
    f.inputs :toilets
    f.inputs :highchairs
    f.inputs :baby_change_room
    f.inputs do
      f.input :user, collection: User.pluck(:email, :id)
    end
    f.inputs do
      f.input :opens_at, as: :time_picker
    end
    f.inputs do
      f.input :closes_at, as: :time_picker
    end
    f.inputs :address
    f.inputs :city
    f.inputs do
      f.input :state, collection: states
    end

    f.inputs "Add images " do
      (8 - f.object.images.size).times do
        f.file_field :images, name: "listing[images][]"
      end
    end
    render 'admin/listings/images', listing: f.object

    f.actions
  end

  index do
    selectable_column
    id_column
    column :business_name
    column :age_range
    column :activity_type
    column :days_available
    column :postcode

    actions
  end

  show do
    default_main_content

    panel "Images" do
      render 'admin/listings/images', listing: listing
    end
  end

  action_item :remove_logo, only: :edit do
    if resource.logo.attached?
      link_to 'Remove Logo', remove_logo_admin_listing_path
    end
  end

  member_action :remove_logo do
    resource.logo.delete
    redirect_to edit_admin_listing_path(resource), notice: "Logo removed successfully."
  end

  collection_action :remove_image do
    resource = Listing.find_by(id: params[:listing_id])
    return redirect_to admin_root_path, notice: "Ambigious input" unless resource.present?
    image = resource.images.find_by(id: params[:id])
    if image.present?
      image.delete
      redirect_to edit_admin_listing_path(resource), notice: "Image Removed successfully."
    else
      redirect_to edit_admin_listing_path(resource), notice: "Image not found."
    end
  end

  action_item :new_invitation, only: [:show] do
    link_to 'Invite User', new_invitation_admin_users_path
  end
end
