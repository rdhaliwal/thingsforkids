class PagesController < ApplicationController
  def contact
    @message = Message.new
  end
end
