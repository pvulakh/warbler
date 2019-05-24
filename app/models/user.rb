# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string           not null
#  location_id     :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  session_token   :string           not null
#

class User < ApplicationRecord
  validates :name, :session_token, presence: true, uniqueness: true
  validates :location_id, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  # allow_nil - why? | when we pull a user out of the db, their password should be nil
  # when we create a new user, their password should be 6 chars or longer
  after_initialize :ensure_session_token # before_validation :ensure_session_token also works

  attr_reader :password

  belongs_to :location, #define a method called `location`
    primary_key: :id, #id inside location table
    foreign_key: :location_id, #inside user table
    class_name: :Location #the model we reference (implicit when good naming conventions, explicit for clarity!)

    has_many :warbles, # has_many tells us the primary_key is in the user table, the foreign_key is in the warble table
    primary_key: :id, # always id!
    foreign_key: :author_id,
    class_name: :Warble
    # As a one-liner: has_many(:warbles, { primary_key: :id, foreign_key: :author_id, class_name: :Warble })

  has_many :likes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Like 
  # FIGVAPER 
  # a fig who vapes

  def self.find_by_credentials(name, password)
    # Find a user with the given name, else return nil
    user = User.find_by(name: name)

    # `is_password?` only executes if user is a User object, not nil
    return nil unless user && user.is_password?(password)
    user
  end

  def password=(password)
    # Store password in an instance variable so it can be validated via the attr_reader
    # password=(password) is run on initialize
    @password = password

    # `BCrypt::Password#create` takes a plaintext password, hashes and salts it, and spits out a digest
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    # This method needs to:
    #   1. Generate a new session token
    #   2. Save it to the database 
    #   3. Return the new session token (optional, but handy)

    self.update!(session_token: self.class.generate_session_token)
    self.session_token
  end

  def is_password?(password)
    # Remember that `password_digest` is just a string!
    # We need to convert it into a BCrypt::Password object so that we can call BCrypt's `#is_password?` on it
    bcrypt_password = BCrypt::Password.new(self.password_digest) # just turns it into a Password object, doesn't hash it again
    
    # This `#is_password?` is an entirely different method
    bcrypt_password.is_password?(password)
  end

  private

  def ensure_session_token
    # This method will run whenever we instantiate a User object:
    #   1. When we create a new record (e.g., `User.new`)
    #   2. When we pull a record out of the database (e.g., `User.first`)
    # ...hence the conditional assignment

    self.session_token ||= self.class.generate_session_token
  end

  def self.generate_session_token
    # Generates a random base64 string
    SecureRandom::urlsafe_base64
  end
end 
