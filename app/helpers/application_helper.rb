module ApplicationHelper
  def facebook_url
    "https://www.facebook.com/thingsforkidsau/"
  end

  def instagram_url
    "https://www.instagram.com/thingsforkidsau/"
  end

  def company_address
    "19062 N 2ND Ave, Phoenix, AZ 85027"
  end

  def active_class(path)
    "active" if current_page?(path)
  end
end
