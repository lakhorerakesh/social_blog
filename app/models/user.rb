class User < ApplicationRecord

  mount_uploader :profile, ProfileUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_profile

  def crop_profile
    profile.recreate_versions! if crop_x.present?
  end

  has_many :posts,  dependent: :destroy
  has_many :votes, through: :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  
  def up_votes
    self.votes.where(vote: true).size
  end

  scope :top_upvoted, -> (limit = 5) {joins(:votes).group("users.id").where("votes.vote = ?", true).order("count(votes.vote) desc").limit(5)}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.token = auth.credentials.token
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def password_required?
    (provider.blank? || uid.blank?) && super
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
