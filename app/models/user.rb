class User < ApplicationRecord
  
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  
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
  
  validates :password, presence: true, length: {minimum: 8}, allow_nil: true
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    
  end
  
  #create a new token
 def User.new_token
  SecureRandom.urlsafe_base64
 end
 
 #remember user for persistent session
 def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
 end
  
  def forget
    update_attribute(:remember_digest,nil)
  end
  
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def downcase_email
    self.email = email.downcase
  end
  
  #Activates an account
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  #Sends an activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  private
  
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  
  
  
end
