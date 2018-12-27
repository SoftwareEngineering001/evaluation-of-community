class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
  has_many :attitude_to_comments, dependent: :destroy
    
end
