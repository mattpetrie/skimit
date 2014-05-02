# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates_uniqueness_of :username

  before_validation :ensure_session_token

  has_many :subs, foreign_key: :moderator_id

  has_many :links, foreign_key: :submitter_id

  attr_reader :password

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.try(:is_password?, password) ? user : nil
  end

  def password=(pass)
    @password = pass
    unless pass == ''
      self.password_digest = BCrypt::Password.create(pass)
    end
  end

  def is_password?(pass)
    BCrypt::Password.new(password_digest).is_password?(pass)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
