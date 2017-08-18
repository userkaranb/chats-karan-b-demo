class MessageController < ActionController::Base

  def index
    wrapped_messages = all_messages_in_history.map do |message|
      wrap_message(message)
    end
    respond_with_message(wrapped_messages)
  end

  def create
    Message.create(user_id: myself_id, to_id: friend_id, body: params['body'])
  end

  private

  def wrap_message(message)
    body = message.body
    created_at = message.created_at
    direction = message.user_id == myself_id ? 1 : 0
    sender = message.user_id == myself_id ? myself_email : friend_email
    MessageWrapper.new(body: body, created_at: created_at, direction: direction, sender: sender)
  end

  def respond_with_message(messages)
    ret = {}
    ret[:json] = messages
    ret[:each_serializer] = MessageSerializer
    render ret
  end

  def all_messages_in_history
    Message.all.select do |message|
      (message.user_id == myself_id and message.to_id == friend_id) ||
      (message.user_id == friend_id and message.to_id == myself_id) 
    end
  end

  def friend_email
    session[:friend]
  end

  def myself_email
    session[:myself]
  end

  def friend_id
    User.find_by(email: friend_email).id
  end

  def myself_id
    User.find_by(email: myself_email).id
  end

end