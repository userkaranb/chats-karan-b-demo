class ChatValidationService
  def initialize(users)
    @users = users
  end

  def get_both_user_info(my_username, friend_username)
    my_info = get_my_id(my_username)
    friend_info = get_friend_id(friend_username)

    { :myself=>my_info, :friend=>friend_info }
  end

  private

  def get_my_id(username)
    user_id = try_get_user_id(username)
    message = ''
    if user_id.nil?
      user_id = create_new_user(username).id
      puts 'User did not previously exist, new user was created'
    end

    package_response(user_id, message)
  end

  def get_friend_id(friend_username)
    id = try_get_user_id(friend_username)
    message = ''
    if id.nil?
      message = 'Friend does not exist. Cannot start chat'
    end

    package_response(id, message)
  end

  def try_get_user_id(username)
    @users.select do |user|
      user.username == username
    end.first.id
  rescue
    nil
  end

  def create_new_user(username)
    User.create(username: username)
  end

  def package_response(user_id, message)
    { :user_id=>user_id, :message=>message }
  end
end