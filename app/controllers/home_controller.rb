class HomeController < ApplicationController

  def contact
    @message = Message.new
  end

end
