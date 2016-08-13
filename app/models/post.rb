class Post < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true,
                    length: { minimum: 5 }
                    
  mount_uploader :image, ImageUploader

  attr_accessor :trim_x, :trim_y, :trim_w, :trim_h
  after_update :trim_image

  def trim_image
    image.recreate_versions! if trim_x.present?
  end

  def self.search(search)
    where("category LIKE ?", "%#{search}%") 
  end

  def total_votes
    self.up_votes - self.down_votes
  end
  
  def up_votes
    self.votes.where(vote: true).size
  end
  
  def down_votes
    self.votes.where(vote: false).size  
  end
end
