class ChatValidationService
  def initialize()
    @users = User.all
  end

  def get_both_user_info(user_email, friend_email)
  	my_info = get_my_id(user_email)
  	friend_info = get_friend_id(friend_email)

  	{ :myself=>my_info, :friend=>friend_info }
  end

  def get_my_id(user_email)
  	user_id = try_get_user_id(user_email)
  	message = ''
  	if user_id.nil?
  	  user_id = create_new_user(user_email).id
  	  puts 'User did not previously exist, new user was created'
  	end

  	package_response(user_id, message)
  end

  def get_friend_id(friend_email)
  	id = try_get_user_id(friend_email)
  	message = ''
  	if id.nil?
  		message = 'friend does not exist. Cannot start chat'
  	end

  	package_response(id, message)
  end

  def try_get_user_id(user_email)
    @users.find_by(email: user_email).id
  rescue
  	nil
  end

  def create_new_user(user_email)
  	User.create(email: user_email)
  end

  def package_response(user_id, message)
  	{ :user_id=>user_id, :message=>message }
  end
end