# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, null: false
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username , :session_token, uniqueness: true
  attr_reader :password

  after_initialize :ensure_session_token

  has_many :subs
  has_many :posts
  has_many :comments 

  def reset_session_token!
    generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(:username=>username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  private

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(128)
  end

  def ensure_session_token
    self.session_token || generate_session_token
  end
end
