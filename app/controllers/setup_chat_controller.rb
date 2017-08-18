class SetupChatController < ActionController::Base

  def index
    render 'username'
  end

  def create
    start_chat
  end

  def start_chat
    session[:myself] = email
    session[:friend] = friend
    # Validate username and friend
    # if ok send to next page.
    redirect_to chat_index_url and return
    #render json: session, status: :ok
  end

  private

  def email
    params[:users][:email]
  rescue
    nil
  end

  def friend
    params[:users][:friend]
  end

  def user_id
    User.find_by(email: email).id
  rescue
    nil
  end
end