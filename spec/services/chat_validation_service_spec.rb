require 'rails_helper'

describe ChatValidationService do
  let(:user1) { MockTestItems.user1 }
  let(:user2) { MockTestItems.user2 }
  let(:users) { [user1, user2] }

  subject { ChatValidationService.new(users) }
  
  it 'should return no error messages for valid users for myself' do
    valid_self = 'abc'
    valid_friend = 'def'
    both_user_info = subject.get_both_user_info(valid_self, valid_friend)
    my_info = both_user_info[:myself]

    expect(my_info[:user_id]).to eq user1.id
    expect(my_info[:message]).to eq ''
  end

  it 'should return no error messages for valid users for friend' do
    valid_self = 'abc'
    valid_friend = 'def'
    both_user_info = subject.get_both_user_info(valid_self, valid_friend)
    friend_info = both_user_info[:friend]

    expect(friend_info[:user_id]).to eq user2.id
    expect(friend_info[:message]).to eq ''
  end

  it 'should create a new user if myself is new' do
    myself = 'xyz'
    valid_friend = 'def'
    user_count = User.all.count
    both_user_info = subject.get_both_user_info(myself, valid_friend)
    new_user_count = User.all.count
    expect(new_user_count).to eq user_count+1
  end

  it 'should return an error message if friend doesnt exist' do
    valid_self = 'abc'
    friend = 'not_a_valid_username'
    both_user_info = subject.get_both_user_info(valid_self, friend)
    friend_info = both_user_info[:friend]
    expect(friend_info[:message]).to eq 'Friend does not exist. Cannot start chat'
  end

  it 'should return the response to the controller in the correct hash' do
    valid_self = 'abc'
    valid_friend = 'def'
    both_user_info = subject.get_both_user_info(valid_self, valid_friend)

    expect(both_user_info.keys).to eq [:myself, :friend]

    my_info = both_user_info[:myself]
    expect(my_info.keys).to eq [:user_id, :message]

    friend_info = both_user_info[:friend]
    expect(friend_info.keys).to eq [:user_id, :message]
  end

  it 'should allow me to talk to myself' do
    valid_self = 'abc'
    valid_friend = 'abc'
    both_user_info = subject.get_both_user_info(valid_self, valid_friend)
    
    my_info = both_user_info[:myself]
    expect(my_info[:user_id]).to eq user1.id
    expect(my_info[:message]).to eq ''

    friend_info = both_user_info[:friend]
    expect(friend_info[:user_id]).to eq user1.id
    expect(friend_info[:message]).to eq ''
  end
end