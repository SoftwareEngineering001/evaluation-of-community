class Course < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :interest_users, class_name: "InterestCourse",foreign_key: "course_id",dependent: :destroy
    has_many :users, through: :interest_users, source: :user
    has_many :instructions
    has_many :teachers, through: :instructions
    has_many :sim_relations, class_name: "Similar", foreign_key: "maincourse_id", dependent: :destroy
    has_many :simcourses, through: :sim_relations, source: :simcourse
    has_many :attitudes
    has_one :rate, dependent: :destroy
    
    require 'csv'
    def Course.readCSV(file)
        csv = CSV.parse(file.read, :headers => true)
        csv.each do |row|
            Course.create(title: row['title'],teacher: row['teacher'])
        end
    end
    
    def sim(other_course)
        sim_relations.create(simcourse_id: other_course.id)
        # sim_relations.create(maincourse_id: other_course.id, simcourse_id: self.id)
    end
    
    def unsim(other_course)
        sim_relations.find_by(simcourse_id: other_course.id).destroy
    end
    
    def same_teacher_courses(teacher)
        @sameteacher_courses = teacher.courses
    end
    
    def follow_count
        if self.attitudes
            self.attitudes.where(has_recom: true).count
        else
            0
        end
    end
    
    def attitudes_colcount(col_name)
        if self.attitudes
            if col_name == 'has_follow'
                self.attitudes.where(has_follow: true).count
            elsif col_name == 'has_recom'
                self.attitudes.where(has_recom: true).count
            elsif col_name == 'has_disrecom'
                self.attitudes.where(has_disrecom: true).count
            elsif col_name == 'has_learn'
                self.attitudes.where(has_learn: true).count
            end
        else
            0
        end
    end
    
end
