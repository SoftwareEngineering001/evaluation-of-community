class Rate < ActiveRecord::Base
    belongs_to :course
    validates :course_id, presence: true
end
