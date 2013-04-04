class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation #creates virtual attribute
  attr_accessible :email, :password, :password_confirmation

  validate :password_matches

  before_create :hash_password

  email_regex =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    uniqueness: true,
                    format: { with: email_regex }


  private

  def hash_password
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(self.password, password_salt)
    self.salt, self.password_hash = [password_salt, password_hash]
  end

  def password_matches
    unless self.password_confirmation == self.password
      errors.add(:password, "does not match")
    end
  end
end
