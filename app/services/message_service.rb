class MessageService
  attr_reader :my_email,
              :my_id,
              :friend_email,
              :friend_id

  def initialize(my_email, my_id, friend_email, friend_id)
    @my_email = my_email
    @my_id = my_id
    @friend_email = friend_email
    @friend_id = friend_id
  end

  def get_conversation_history
    get_conversation_history_from_db.map do |message|
      wrap_message(message)
    end
  end

  def create_new_message(body)
    Message.create(user_id: my_id, to_id: friend_id, body: body)
  end

  private

  def get_conversation_history_from_db
    Message.all.select do |message|
      (message.user_id == my_id and message.to_id == friend_id) ||
      (message.user_id == friend_id and message.to_id == my_id) 
    end
  end

  def wrap_message(message)
    body = message.body
    created_at = message.created_at
    direction = message.user_id == my_id ? 1 : 0
    sender = message.user_id == my_id ? my_email : friend_email
    MessageWrapper.new(body: body, created_at: created_at, direction: direction, sender: sender)
  end
end