class User < ActiveRecord::Base

  has_secure_password

  validates_uniqueness_of :email, presence: true, case_sensitive: false
  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    formatEmail = email.downcase.strip
    user = User.find_by(email: formatEmail)
    user && user.authenticate(password) ? true : false
  end

end