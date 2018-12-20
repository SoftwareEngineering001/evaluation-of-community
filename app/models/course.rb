class Course < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :interest_users, class_name: "InterestCourse",foreign_key: "course_id",dependent: :destroy
    has_many :users, through: :interest_users, source: :user
    require 'csv'
    def Course.readCSV(file)
        csv = CSV.parse(file.read, :headers => true)
        csv.each do |row|
            Course.create(title: row['title'],teacher: row['teacher'])
        end
    end
end
