ActiveAdmin.register Listing do
  permit_params :activity_type, :min_age, :max_age, :business_name, :description, :logo,
                :facbook_url, :instagram_url, :manager_name, :manager_job_title, :phone, :email, :website, :price,
                :zip_code, :please_bring, :indoors, :outdoors, :parties, :disability_access, :parking, :free_trial,
                :undercover, :bbq, :toilets, :highchairs, :baby_change_room, :opens_at, :closes_at, :address, :city, :state,
                days_available: [], images: []

  form do |f|
    f.inputs :business_name
    f.inputs :min_age
    f.inputs :max_age
    f.inputs :activity_type
    f.inputs :description
    f.inputs do
      f.input :days_available, as: :check_boxes, collection: Listing::WEEK_DAYS
    end
    f.inputs "Add logo" do
      f.file_field :logo
    end
    f.inputs :facbook_url
    f.inputs :instagram_url
    f.inputs :manager_name
    f.inputs :manager_job_title
    f.inputs :phone
    f.inputs :email
    f.inputs :website
    f.inputs :price
    f.inputs :zip_code
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
      f.input :opens_at, as: :date_picker
    end
    f.inputs do
      f.input :closes_at, as: :date_picker
    end
    f.inputs :address
    f.inputs :city
    f.inputs :state

    f.inputs "Add images " do
      (8 - f.object.images.size).times do
        f.file_field :images, name: "listing[images][]"
      end
    end

    f.actions
  end
end
