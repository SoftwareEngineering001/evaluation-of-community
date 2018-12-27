class Similar < ActiveRecord::Base
    belongs_to:maincourse, class_name: "Course"
    belongs_to:simcourse, class_name: "Course"
    validates :maincourse_id, presence: true
    validates :simcourse_id, presence: true
end
