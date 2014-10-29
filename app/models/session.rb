# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  session_token :string(255)      not null
#  request_ip    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Session < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  
  belongs_to :user
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end  
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  
  # def ensure_session_token
#     self.session_token ||= self.class.generate_session_token
#   end
end
