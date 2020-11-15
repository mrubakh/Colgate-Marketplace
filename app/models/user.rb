class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
         
  has_many :items

#User checked and created here with SSO
  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first
      
      unless user
          user = User.create(email: data['email'],
          name: data['name'],
              password: Devise.friendly_token[0,20]
          )
      end
      user
  end
end
