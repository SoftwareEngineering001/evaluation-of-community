class Course < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    require 'csv'
    def Course.readCSV(file)
        csv = CSV.parse(file.read, :headers => true)
        csv.each do |row|
            Course.create(title: row['title'],teacher: row['teacher'])
        end
    end
end
