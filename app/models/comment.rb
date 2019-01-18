class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :content, presence: true, length: { minimum: 15 }
  validates :difficulty, presence: true
  validates :homework, presence: true
  validates :gain, presence: true
  validates :grading, presence: true
  validates :ratescore, presence: true, numericality: { greater_than: 0 }
  default_scope -> { order(created_at: :desc) }
  has_many :attitude_to_comments, dependent: :destroy
    
end
