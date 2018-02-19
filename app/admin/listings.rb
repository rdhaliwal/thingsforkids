ActiveAdmin.register Listing do
  permit_params :days_available, :activity_type, :min_age, :max_age, :business_name, :description, :logo,
                :facebook_url, :instagram_url, :manager_nmae, :manager_job_title, :phone, :email, :website, :price,
                :zip_code, :please_brings, :indoors, :outdoors, :parties, :disability_access, :parking, :free_trial,
                :undercover, :bbq, :toilets, :highchairs, :baby_change_room, :opens_at, :closes_at
end
