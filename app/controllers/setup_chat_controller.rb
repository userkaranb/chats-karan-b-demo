class SetupChatController < ActionController::Base

  layout 'application'

  def index
    render 'username'
  end

  def create
    start_chat
  end

  def start_chat
    session[:my_email] = email
    session[:friend_email] = friend
    if validate(email, friend)
      redirect_to chat_index_url and return
    else
      redirect_to root_url and return  
    end
  end

  def validate(email, friend_email)
    info = chat_validation_service.get_both_user_info(email, friend_email)
    message = ''

    if not info[:friend][:message].empty?
      message = "#{message}. #{info[:friend][:message]}"
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
    @chat_validation_service ||= ChatValidationService.new
  end

  def email
    params[:users][:email]
  rescue
    nil
  end

  def friend
    params[:users][:friend]
  rescue
    nil
  end
end