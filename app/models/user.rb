# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  provider               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  uid                    :string(255)
#  social_url             :string(255)
#  picture_url            :string(255)
#  gender                 :string(255)
#  birthday               :string(255)
#  location               :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  validates :name, presence: true
  validates :email, uniqueness: true

  devise :omniauthable, omniauth_providers: [:vkontakte]

  def self.find_for_vkontakte(access_token, signed_in_resource=nil)
    data = access_token.info
    email = access_token.extra.raw_info['screen_name'].to_s + '@vk.com'
    user = User.where(provider: access_token.provider, uid: access_token.uid.to_s).first

    unless user
      user = User.create(
                         name: data["last_name"].to_s + data["first_name"].to_s,
                         provider: access_token.provider,
                         uid: access_token.uid,
                         email: email,
                         password: Devise.friendly_token[0, 20],
                         social_url: data.urls['Vkontakte'],
                         picture_url: data.image,
                         gender: access_token.extra.raw_info.sex,
                         location: data.location,
                         birthday: access_token.extra.raw_info.bdate

      )
    end
    user
  end
end
