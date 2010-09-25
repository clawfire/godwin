dummy_salt = Array.new(32, '#').join ''
dummy_hash = Array.new(32, '0').join ''

unless User.all.size > 0
  # Base user (username = admin, password = admin)
  User.create(:login => 'admin', :priviledged => true) do |admin|
    admin.password= 'admin'
  end
end

unless User.find_by_login('anonymous')
  # System account "Anonymous" needs to exist.
  User.create(:login => 'anonymous', :priviledged => false) do |anonymous|
    anonymous.id = -1
    anonymous.password= 'Login is not Allowed for Anonymous anyway.'
  end
end