class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  def avatar_image
    # if profile&.avatar&.attached?
    #   profile.avatar
    # else
    'profile01.png'
    # end
  end
end
