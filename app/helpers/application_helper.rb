module ApplicationHelper
  def facebook_url
    "https://www.facebook.com/thingsforkidsau/"
  end

  def instagram_url
    "https://www.instagram.com/thingsforkidsau/"
  end

  def company_address
    "Melbourne, Victoria, 3000"
  end

  def active_class(path)
    "active" if current_page?(path)
  end
end
