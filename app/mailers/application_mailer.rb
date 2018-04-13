class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@thingsforkids.com.au'
  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  layout 'mailer'
end
