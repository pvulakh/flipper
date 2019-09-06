# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  username    :string           not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ApplicationRecord
  # don't need to explicitly validate location_id because Rails automatically validates foreign keys
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }  # password is never stored in DB (no column exists), so when we pull an existing user from DB, user.password returns nil
  after_initialize :ensure_session_token
  # validations call the getter methods for each attribute 
  # as password is not a column, we define the getter here so we can validate it for length
  attr_reader :password

  # FIG VAPER - need to write these methods, validations, and callbacks in User model to implement auth pattern
    # F - ::find_by_credentials
    # I - #is_password?
    # G - ::generate_session_token
    # V - validates :password
    # A - attr_reader :password
    # P - #password=
    # E - #ensure_session_token
    # R - #reset_session_token!

  has_many :authored_flips,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Flip

  belongs_to :location,
    primary_key: :id,
    foreign_key: :location_id,
    class_name: :Location
    # optional: true # to disable automatic validation

  has_many :likes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Like 

  has_many :liked_flips,
    through: :likes,
    source: :flip
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.is_password?(password)
    user
  end
  
  def password=(password)
    @password = password  # this instance var is needed only to validate the password's length
    self.password_digest = BCrypt::Password.create(password)  # the password_digest is what gets saved to DB (in place of the password itself)
    # BCrypt::Password.create takes a password, salts and hashes it, returning our digest
  end

  def is_password?(password)
    bcrypt_pw = BCrypt::Password.new(self.password_digest)  # bcrypt_pw is a BCrypt::Password object
    bcrypt_pw.is_password?(password)  # is_password? is a method that a BCrypt::Password object can respond to
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
    # random base64 string to serve as our token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!  # save can be used either to create a new record or update an existing one
    self.session_token
  end

end
