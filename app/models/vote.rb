class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :user, scope: :post_id

  validate :ensure_not_author
  
  def ensure_not_author
    errors.add :user_id, "is the author of the post" if post.user_id == user_id
  end
end




