unless User.find(:all, :conditions => { :priviledged => true }).size > 0
  # Base user (username = admin, password = admin)
  User.create(:login => 'admin', :email => 'admin@godwin.com', :priviledged => true) do |admin|
    admin.create_profile(:display_name => 'Administrator')
    admin.password= 'admin'
  end
end

unless User.find_by_login('anonymous')
  # System account "Anonymous" needs to exist.
  User.create(:login => 'anonymous', :email => 'nobody@godwin.com', :priviledged => false) do |anonymous|
    anonymous.id = -1
    anonymous.create_profile(:display_name => 'Anonymous')
    anonymous.password= 'Login is not Allowed for Anonymous anyway.'
  end
end