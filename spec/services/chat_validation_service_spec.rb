require 'rails_helper'

describe ChatValidationService do
  let(:user1) { MockTestItems.user1 }
  let(:user2) { MockTestItems.user2 }
  
  it 'should return true' do
  	expect(user1.username).to eq 'abc'
  end
end