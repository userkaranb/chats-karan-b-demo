require 'rails_helper'

describe MessageWrapper do
  let(:body) { 'Good morning' }
  let(:created_at) { DateTime.new(2017, 6, 18, 15, 30, 20) }
  let(:direction) { 1 }
  let(:sender) { 'karan' }

  subject { MessageWrapper.new(body: body, created_at: created_at, direction: direction, sender: sender)}

  it 'should have an accessible body' do
    expect(subject.body).to eq body
  end

  it 'should have an accessible created_at' do
    expect(subject.created_at).to eq created_at
  end

  it 'should have an accessible direction' do
    expect(subject.direction).to eq direction
  end

  it 'should have an accessible sender' do
    expect(subject.sender).to eq sender
  end
end