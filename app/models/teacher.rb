class Teacher < ActiveRecord::Base
    has_many :instructions
    has_many :courses, through: :instructions
    
    def instruct(course)
        instructions.create(course_id: course.id)
    end
end
