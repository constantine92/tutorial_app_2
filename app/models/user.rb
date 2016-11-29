class User < ApplicationRecord
  
  before_save { self.email = email.downcase }
  VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, 
            presence: true, 
            length: { maximum: 50 }
  validates :email, 
            presence: true, 
            length: { maximum: 255 }, 
            format: {with: VALID_REGEX_EMAIL},
            uniqueness: {case_sensitive: false}
  
  has_secure_password
  
  validates :password, presence: true, length: {minimum: 8}
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    
  end
  
end
