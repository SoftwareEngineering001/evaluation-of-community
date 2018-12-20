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
    has_many :interest_courses, class_name: "InterestCourse",foreign_key: "user_id",dependent: :destroy
    has_many :courses, through: :interest_courses, source: :course

    
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
    def interest(course)
        interest_courses.create(course_id: course.id)
    end
    def uninterest(course)
        interest_courses.find_by(course_id: course.id).destroy
    end
    def interesting?(course)
        courses.include?(course)
    end
    def notify_comments
        Comment.where(user_id: followings.ids).or(course_id: courses.ids).where("created_at > ?",self.logout_time)
    end
end
