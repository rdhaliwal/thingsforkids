class MessagesMailer < ApplicationMailer
  def message_notification message_id, receiver
    receiver = receiver.present? ? User.find(receiver).email : Mails["admin_email"]
    @message = Message.find(message_id)
    mail(to: receiver, bcc: 'ahmadsaleem93@gmail.com', subject: @message.title)
  end
end
