require 'rails_helper'

describe SetupChatController, type: :controller do
  describe 'GET #index' do
    it 'should render username template' do
      get :index
      expect(response).to render_template('username')
    end
  end

  describe 'POST #create' do
    let(:user1) { MockTestItems.user1 }
    let(:user2) { MockTestItems.user2 }
    let(:users) { [user1, user2] }
    let(:chat_validation_service) { ChatValidationService.new(users) }
    
    before(:each) do
      SetupChatController.any_instance.stub(
        :chat_validation_service
      ).and_return(chat_validation_service)
    end

    it 'should redirect to root url, invalid username' do
      params = {
        users: {
          username: 'notAUser',
          friend: 'notAUser2'
        }
      }
      post :create, params: params
      expect(response).to redirect_to(root_url)
    end

    it 'should flash with invalid friend' do
      params = {
        users: {
          username: 'new_user',
          friend: 'new_friend'
        }
      }
      post :create, params: params
      expect(flash[:error].empty?).to eq false
    end

    it 'should redirect to chat index with valid users' do
      params = {
        users: {
          username: 'abc',
          friend: 'def'
        }
      }
      post :create, params: params
      expect(response).to redirect_to(chat_index_url)
    end

    it 'should redirect to chat index with valid friend and new user' do
      params = {
        users: {
          username: 'new_user',
          friend: 'def'
        }
      }
      post :create, params: params
      expect(response).to redirect_to(chat_index_url)
    end

    it 'should redirect to chat index with no flash message' do
      params = {
        users: {
          username: 'new_user',
          friend: 'def'
        }
      }
      post :create, params: params
      expect(flash[:error].empty?).to eq true
    end
  end
end