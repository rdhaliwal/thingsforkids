class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_many :listings
  has_many :messages

  def full_name
    "#{first_name} #{last_name}"
  end

  def block_from_invitation?
    false
  end
end
