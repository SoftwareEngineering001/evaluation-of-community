# -*- coding: UTF-8 -*-
class Course < ActiveRecord::Base
    has_many :comments, dependent: :destroy
   # has_many :interest_users, class_name: "InterestCourse",foreign_key: "course_id",dependent: :destroy
   # has_many :users, through: :interest_users, source: :user
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
            cur_course = Course.create(
                code: row[1]?row[1].force_encoding("UTF-8"):nil,  #课程编码
                title: row[2]?row[2].force_encoding("UTF-8"):nil,  #课程名称
                title_en: row[3]?row[3].force_encoding("UTF-8"):nil, #英文名称
                course_major: row[4]?row[4].force_encoding("UTF-8"):nil,#课程属性
                dept: row[8]?row[8].force_encoding("UTF-8"):nil,#教师所属单位
                subject: row[5]?row[5].force_encoding("UTF-8"):nil,#所属学科/专业
                period_credit: row[6]?row[6].force_encoding("UTF-8"):nil #课时/学分
                )
            teachers=row[7]?row[7].force_encoding("UTF-8").split(','):[]
            teachers.each do |t_name|
                t = Teacher.find_by(name: t_name)
                if !t
                    t = Teacher.create(name: t_name, dept: row[8]?row[8].force_encoding("UTF-8"):nil)
                end
                t.instruct(cur_course)
            end
            #查找绑定相似课程
            # Client.where(first_name: 'Lifo').take
            sim_courses = Course.where(title: cur_course.title).take(40)
            if sim_courses != nil and sim_courses != cur_course
                if sim_courses.instance_of? Course
                    if sim_courses != cur_course
                        cur_course.sim(sim_courses)
                        sim_courses.sim(cur_course)
                    end
                else
                    sim_courses.each do |sim_course|
                        if sim_course != cur_course
                            cur_course.sim(sim_course)
                            sim_course.sim(cur_course)
                        end
                    end
                end
            end
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
        if teacher.eql?("0")
        else
            @sameteacher_courses = teacher.courses
        end
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
    
    def update_course_rate(course, comment_params)
        @total_extra = 0, @total_gra = 0, @total_home = 0, @total_diff = 0, @total_gain = 0, @total_rate = 0
        if(rate = Rate.find_by(course_id: course.id))
            for comment in course.comments do
                @total_rate += comment.ratescore
                @total_diff += comment.difficulty.to_i
                @total_home += comment.homework.to_i
                @total_gra += comment.grading.to_i
                @total_gain += comment.gain.to_i
                
                
            end
            ave_rate = @total_rate.to_f/course.comments.count
            ave_diff = @total_diff.to_f/course.comments.count
            ave_home = @total_home.to_f/course.comments.count
            ave_gra = @total_gra.to_f/course.comments.count
            ave_gain = @total_gain.to_f/course.comments.count
            if(ave_diff < 1.67)
                string_diff = '简单'
            elsif(ave_diff < 2.34)
                string_diff = '中等'
            else
                string_diff = '困难'
            end
            
            if(ave_home < 1.67)
                string_home = '不多'
            elsif(ave_home < 2.34)
                string_home = '中等'
            else
                string_home = '超多'
            end
            
            if(ave_gra < 1.67)
                string_gra = '超好'
            elsif(ave_gra < 2.34)
                string_gra = '一般'
            else
                string_gra = '杀手'
            end
            
            if(ave_gain < 1.67)
                string_gain = '很多'
            elsif(ave_gain < 2.34)
                string_gain = '一般'
            else
                string_gain = '没有'
            end
            rate.update(average_rate: ave_rate, difficulty: string_diff, homework: string_home, grading: string_gra, gain: string_gain)
        else
            Rate.create(course_id: course.id, difficulty: comment_params[:difficulty], homework: comment_params[:homework],
            grading: comment_params[:grading], gain: comment_params[:gain], average_rate: comment_params[:ratescore])
        end
    end
    
end
