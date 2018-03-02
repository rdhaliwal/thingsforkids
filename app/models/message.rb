class Message < ApplicationRecord
  belongs_to :user, optional: true

  validates :sender_name, :sender_email, :title, :message, presence: true
end
