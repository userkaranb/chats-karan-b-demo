class SetupChatController < ActionController::Base

  layout 'application'

  def index
    render 'username'
  end

  def create
    start_chat
  end

  def start_chat
    session[:my_username] = username
    session[:friend_username] = friend
    if validate(username, friend)
      redirect_to chat_index_url and return
    else
      redirect_to root_url and return  
    end
  end

  def validate(username, friend_username)
    info = chat_validation_service.get_both_user_info(username, friend_username)
    message = ''

    if not info[:friend][:message].empty?
      message = "#{info[:friend][:message]}"
      flash[:error] = message
      return false
    end

    flash[:error] = ''
    session[:my_id] = info[:myself][:user_id]
    session[:friend_id] = info[:friend][:user_id]
    return true
  end

  private

  def chat_validation_service
    @chat_validation_service ||= ChatValidationService.new(User.all.to_a)
  end

  def username
    params[:users][:username]
  rescue
    nil
  end

  def friend
    params[:users][:friend]
  rescue
    nil
  end
end