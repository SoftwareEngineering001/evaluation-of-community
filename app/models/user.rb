class User < ActiveRecord::Base
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@(mails\.)?ucas\.ac\.cn\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password
    has_many :comments, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
    has_many :followings, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    has_many :attitudes, dependent: :destroy #这个attitude对应的是用户对课程的关注，推荐，不推荐和学过四个操作
    has_many :attitude_to_comments, dependent: :destroy

    def User.new_token
        SecureRandom.urlsafe_base64
    end
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def follow(other_user)
        active_relationships.create(followed_id: other_user.id)
    end
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end
    def following?(other_user)
        followings.include?(other_user)
    end
    def courses
        Course.where(id: attitudes.where(:has_follow=>true).select(:course_id)) 
    end
    def notify_comments
        Comment.where(user_id: followings.ids).or(course_id: courses.ids).where("created_at > ?",self.logout_time)
    end
    
    def follow_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.update(has_follow: true)
            # attitude.has_follow = true
            # attitude.save
        else
            attitudes.create(course_id: course.id, has_follow: true)
        end
    end
    
    def unfollow_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_follow = false
            attitude.save
            if(attitude.has_follow == false and attitude.has_recom==false and attitude.has_disrecom == false and attitude.has_learn == false)
                attitude.destroy
            end
        end
    end
    def recom_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_recom = true
            attitude.save
        else
            attitudes.create(course_id: course.id, has_recom: true)
        end
    end
    
    def unrecom_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_recom = false
            attitude.save
            if(attitude.has_follow == false and attitude.has_recom==false and attitude.has_disrecom == false and attitude.has_learn == false)
                attitude.destroy
            end
        end
    end
    def disrecom_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_disrecom = true
            attitude.save
        else
            attitudes.create(course_id: course.id, has_disrecom: true)
        end
    end
    
    def undisrecom_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_disrecom = false
            attitude.save
            if(attitude.has_follow == false and attitude.has_recom==false and attitude.has_disrecom == false and attitude.has_learn == false)
                attitude.destroy
            end
        end
    end
    def learn_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_learn = true
            attitude.save
        else
            attitudes.create(course_id: course.id, has_learn: true)
        end
    end
    
    def unlearn_course(course)
        if(attitude = attitudes.find_by(course_id: course.id))
            attitude.has_learn = false
            attitude.save
            if(attitude.has_follow == false and attitude.has_recom==false and attitude.has_disrecom == false and attitude.has_learn == false)
                attitude.destroy
            end
        end
    end
    
    def approve_comment(comment)
        attitude_to_comments.create(comment_id: comment.id)
    end
    
    def unapprove_comment(comment)
        attitude_to_comments.find_by(comment_id: comment.id).destroy
    end
end
