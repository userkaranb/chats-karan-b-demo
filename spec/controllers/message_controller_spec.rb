require 'rails_helper'

describe MessageController, type: :controller do
  let(:user1) { MockTestItems.user1 }
  let(:user2) { MockTestItems.user2 }
  let(:messages) { MockTestItems.example_messages }
  let(:message_service) { MessageService.new(user1.username, user1.id, user2.username, user2.id) }
  before(:each) do
  	MessageService.any_instance.stub(
  	  :all_messages
	).and_return(messages)

  	MessageController.any_instance.stub(
  	  :message_service
	).and_return(message_service)
  end

  describe 'GET #index' do
    it 'should respond with all messages' do
      get :index
      expect(response.body).to eq "[{\"body\":\"Hello user 2, its user 1\",\"created_at\":null,\"direction\":1,\"sender\":\"abc\"},{\"body\":\"Hello user 1, its user 2. Good morning.\",\"created_at\":null,\"direction\":0,\"sender\":\"def\"},{\"body\":\"Good Morning to you too.\",\"created_at\":null,\"direction\":1,\"sender\":\"abc\"}]"
    end
  end

  describe 'POST #create' do
  	it 'should respond with the newly created message' do
  	  params = {
  	  	body: 'This is a new message'
  	  }

  	  post :create, params: params
  	  expect(response.body).to eq "{\"body\":\"This is a new message\",\"created_at\":null,\"direction\":1,\"sender\":\"abc\"}"
  	end
  end
end