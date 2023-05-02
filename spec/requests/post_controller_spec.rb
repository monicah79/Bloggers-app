require 'rails_helper'

RSpec.describe PostController, type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/user/1/post'
      expect(response).to be_successful
    end

    it 'renders the index template of views/users' do
      get '/user/1/post'
      expect(response).to render_template(:index)
    end

    it 'indicate the correct placeholder text' do
      get '/user/1/post'
      result = response.body
      expect(result).to include('Shows the details of posts for a given user')
    end

    describe 'GET #show' do
      it 'returns a success response' do
        get '/user/1/post'

        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        get '/user/1/post'
      end

      it 'indicate the correct placeholder text' do
        get '/user/1/post'
        result = response.body
        expect(result).to include('Shows the details of posts for a given user')
      end
    end
  end
end
