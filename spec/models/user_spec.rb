require 'rails_helper'

describe User do
  def try_save(user)
  	user.save
  	true
  rescue
  	false
  end

  it 'cannot have an nil username' do
    user = User.new(username: nil)
    expect(try_save(user)).to eq false
  end

  it 'cannot have an empty username' do
  	user = User.new(username: '')
  	expect(try_save(user)).to eq false
  end
end