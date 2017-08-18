class MessageController < ActionController::Base

  def index
    respond_with_message(message_service.get_conversation_history)
  end

  def create
    message_service.create_new_message(params['body'])
  end

  private

  def respond_with_message(messages)
    ret = {}
    ret[:json] = messages
    ret[:each_serializer] = MessageSerializer
    render ret
  end

  def message_service
    @message_service ||= MessageService.new(session[:my_email], session[:my_id], session[:friend_email], session[:friend_id])
  end

end