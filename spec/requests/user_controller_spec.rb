require 'rails_helper'

RSpec.describe UserController, type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/user/'
      expect(response).to be_successful
    end

    it 'renders the index template of views/users' do
      get '/user/'
      expect(response).to render_template(:index)
    end
  end
  it 'display the correct correct placeholder text' do
    get '/user/'
    result = response.body
    expect(result).to include('Here is a list of all user')
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get '/user/1'
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get '/user/1'
      expect(response).to render_template(:show)
    end

    it 'display the correct placeholder text' do
      get '/user/1'
      result = response.body
      expect(result).to include('Shows the details of selected user')
    end
  end
end
