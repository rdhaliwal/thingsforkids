class HomeController < ApplicationController
  def index
    @listing = Listing.new
  end
end
