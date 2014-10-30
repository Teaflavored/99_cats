# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  # validates :user_name, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  
  has_many :cat_rental_requests, dependent: :destroy
  has_many :cats, dependent: :destroy
  has_many :sessions

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil if @user.nil?
    return nil unless @user.is_password?(password)
    
    @user
  end

end
