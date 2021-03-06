class MessageService
  attr_reader :my_username,
              :my_id,
              :friend_username,
              :friend_id

  def initialize(session)
    @my_username = session[:my_username]
    @my_id = session[:my_id]
    @friend_username = session[:friend_username]
    @friend_id = session[:friend_id]
  end

  def get_conversation_history
    get_conversation_history_from_db.map do |message|
      wrap_message(message)
    end
  end

  def create_new_message(body)
    wrap_message(Message.create(user_id: my_id, to_id: friend_id, body: body))
  end

  private

  def all_messages
    (my_user.messages + friend_user.messages).sort_by(&:created_at)
  end

  def get_conversation_history_from_db
    all_messages.select do |message|
      (message.user_id == my_id and message.to_id == friend_id) ||
      (message.user_id == friend_id and message.to_id == my_id) 
    end
  end

  def my_user
    User.find(my_id)
  end

  def friend_user
    User.find(friend_id)
  end

  def wrap_message(message)
    body = message.body
    created_at = message.created_at
    direction = message.user_id == my_id ? 1 : 0
    sender = message.user_id == my_id ? my_username : friend_username
    MessageWrapper.new(body: body, created_at: created_at, direction: direction, sender: sender)
  end
end