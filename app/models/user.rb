class User < ActiveRecord::Base
  #--
  # References & Integrity
  #++
  has_one :profile
  attr_protected :id, :password_salt, :password_hash
  
  # Login needs to be there & unique
  validates_presence_of :login
  validates_uniqueness_of :login, :scope => :id, :case_sensitive => false
  # We need some basic information about authentication
  validates_presence_of :password_salt, :password_hash
  validates_length_of :password_hash, :is => 64
  
  #--
  # Methods
  #++
  
  # Determines if the user has root priviledges or not.
  def priviledged?
    @priviledged
  end
  
  # Renews the password_salt and hashes the new password with it.
  def password=(new_pass)
    validate_password new_pass
    self.password_salt = User.random_string
    self.password_hash = digest(new_pass)
  end
  
  # Validates whether the password is safe enough
  def validate_password(password)
    raise 'Password cannot be empty!' if password.empty?
  end
  private :validate_password
  
  #--
  # Class methods
  #++
  
  # Checks a login/password pair
  def self.authenticate(login, password)
    user = self.find_by_login(login)
    return nil if user.nil?
    digested_password = User.digest(password, user.password_salt)
    return user if digested_password == user.password_hash
    puts "#{digested_password} != #{user.password_hash}"
    return nil
  end
  
  #--
  # Helper protected methods
  #++
protected
  # Generates a random string of printable characters of specified length.
  def self.random_string(length = 32)
    # allowed_chars contains all printable characters
    allowed_chars = ("\x21".."\x7E").to_a
    string = ''
    1.upto(length) do |x|
      string << allowed_chars[rand(allowed_chars.size - 1)]
    end
    return string
  end
  
  # Digests a string using the user's salt and an application-level salt.
  def digest(string)
    User.digest(string, self.password_salt)
  end
  
  # Digests a string using a given hash.
  def self.digest(string, salt)
    Digest::SHA2.hexdigest("#{SecurityConfig[:common_password_salt]}#{string}#{salt}")
  end
end