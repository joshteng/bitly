class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  validate :password_matches

  email_regex =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    uniqueness: true,
                    format: { with: email_regex }



  def self.hash_password(password)
    #to make it more sophisticated eventually
    password + '11111'
  end

  private

  def password_matches
    if self.password_confirmation == self.password
      self.password_hash = User.hash_password(self.password)
    else
      errors.add(:password, "does not match")
    end
  end
end
