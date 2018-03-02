class MessagesController < ApplicationController
  before_action :set_user, only: [:create]

  def create
    @message = Message.new(message_params.merge({user: @user}))
    if @message.save
      receiver = @user.present? ? @user.id : nil
      MessagesMailer.message_notification(@message.id, receiver).deliver_later
      redirect_to create_redirect_path, notice: "Your message sent successfully."
    else
      render create_render_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:sender_name, :sender_email, :title, :message)
    end

    def set_user
      @listing = Listing.find_by(id: params[:listing_id]) if params[:listing_id].present?
      @user = @listing.user if @listing.present?
    end

    def create_redirect_path
      return @listing if @listing.present?
      listings_path
    end

    def create_render_path
      return "listings/show" if @listing.present?
      'home/contact'
    end
end
