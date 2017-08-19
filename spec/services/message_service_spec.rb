require 'rails_helper'

describe MessageService do
  let(:user1) { MockTestItems.user1 }
  let(:user2) { MockTestItems.user2 }
  let(:messages) { MockTestItems.example_messages }
  
  describe 'Message data will not change' do
    before(:each) do
      MessageService.any_instance.stub(
        :all_messages
      ).and_return(messages)
    end

    subject { MessageService.new(MockTestItems.create_fake_session_hash(user1, user2)) }
    
    it 'should return the correct history for users 1 and 2' do
      history = subject.get_conversation_history
      expect(history.count).to eq 3
      expected_message_bodies = [
        'Hello user 2, its user 1',
        'Hello user 1, its user 2. Good morning.',
        'Good Morning to you too.'
      ]

      expect(history.map(&:body)).to match_array expected_message_bodies
    end

    it 'should return the same messages for users 1 and 2 through the perspective of the friend' do
      service = MessageService.new(MockTestItems.create_fake_session_hash(user2, user1))
      history = subject.get_conversation_history
      expect(history.count).to eq 3
      expected_message_bodies = [
        'Hello user 2, its user 1',
        'Hello user 1, its user 2. Good morning.',
        'Good Morning to you too.'
      ]

      expect(history.map(&:body)).to match_array expected_message_bodies
    end

    it 'should return the correct history for messages to myself' do
      service = MessageService.new(MockTestItems.create_fake_session_hash(user1, user1))
      history = service.get_conversation_history
      expect(history.count).to eq 1
      expected_message_bodies = ['Note to self: Buy Groceries.']
      expect(history.map(&:body)).to match_array expected_message_bodies
    end

    it 'should return no history for users that have never talked' do
      service = MessageService.new(MockTestItems.create_fake_session_hash(user2, user2))
      history = service.get_conversation_history
      expect(history.count).to eq 0
    end

    it 'should return a list of wrapped messages' do
      history = subject.get_conversation_history
      first_item = history.first
      expect(first_item.class).to eq MessageWrapper
    end
  end

  it 'should make sure both the friend and myself view new messages as they are created' do
    user1.save
    user2.save
    Message.create(user_id: 1, to_id: 2, body: 'Hello user 2, its user 1')
    Message.create(user_id: 2, to_id: 1, body: 'Hello user 1, its user 2. Good morning.')
    Message.create(user_id: 1, to_id: 3, body: 'Hello user 3, its user 1')
    Message.create(user_id: 2, to_id: 3, body: 'Hello user 3, its user 2')
    Message.create(user_id: 3, to_id: 2, body: 'Hello user 2. Good Morning.')
    Message.create(user_id: 1, to_id: 2, body: 'Good Morning to you too.')
    Message.create(user_id: 1, to_id: 1, body: 'Note to self: Buy Groceries.')

    my_perspective = MessageService.new(MockTestItems.create_fake_session_hash(user1, user2))
    friends_perspective = MessageService.new(MockTestItems.create_fake_session_hash(user2, user1))

    expect(my_perspective.get_conversation_history.count).to eq 3
    expect(friends_perspective.get_conversation_history.count).to eq 3

    my_perspective.create_new_message('You still there user2?')
    expect(my_perspective.get_conversation_history.count).to eq 4
    expect(friends_perspective.get_conversation_history.count).to eq 4

    friends_perspective.create_new_message('Im still here, User1')
    expect(my_perspective.get_conversation_history.count).to eq 5
    expect(friends_perspective.get_conversation_history.count).to eq 5
  end
end