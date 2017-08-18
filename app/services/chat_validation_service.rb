class ChatValidationService
  def initialize()
    @users = User.all
  end

  def get_both_user_info(user_username, friend_username)
  	my_info = get_my_id(user_username)
  	friend_info = get_friend_id(friend_username)

  	{ :myself=>my_info, :friend=>friend_info }
  end

  def get_my_id(user_username)
  	user_id = try_get_user_id(user_username)
  	message = ''
  	if user_id.nil?
  	  user_id = create_new_user(user_username).id
  	  puts 'User did not previously exist, new user was created'
  	end

  	package_response(user_id, message)
  end

  def get_friend_id(friend_username)
  	id = try_get_user_id(friend_username)
  	message = ''
  	if id.nil?
  		message = 'friend does not exist. Cannot start chat'
  	end

  	package_response(id, message)
  end

  def try_get_user_id(user_username)
    @users.find_by(username: user_username).id
  rescue
  	nil
  end

  def create_new_user(user_username)
  	User.create(username: user_username)
  end

  def package_response(user_id, message)
  	{ :user_id=>user_id, :message=>message }
  end
end