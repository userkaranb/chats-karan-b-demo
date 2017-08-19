require 'rails_helper'

describe ChatController, type: :controller do
  describe 'GET #index' do
    it 'should render chatroom template' do
      get :index
      expect(response).to render_template('chatroom')
    end
  end
end