class User < ApplicationRecord
    has_many :microposts
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    has_secure_password validations: true
    
    # Skip password validation if password_digest is already set (for fixtures)
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
