# spec/requests/articles_spec.rb

require 'rails_helper'

RSpec.describe "Articles", type: :request do

  # Testing for articles
  describe 'GET /articles' do
    # make http get request before each example
    before { get '/articles' }

    it 'returns articles' do
       expect(json).not_to be_empty
       expect(json.size).to eq(10)
     end

    it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
  end


  # Testing for article retrieval
  describe 'GET /articles/:id' do
    before { get "/articles/#{article_id}" }

    context 'when the record exists' do
      it 'returns the article' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(article_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:article_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Article/)
      end
    end
  end


  # Test for 'by_user_group'
  describe 'GET /articles/by_user_group/:user_group' do
    before { get "/articles/by_user_group/#{user_group}" }

    # <insert test cases here> (for existence of user group articles?)
    context '<placeholder>' do
      it '<placeholder>' do
        expect(<placeholder>)
      end
    end
  end


  # Test suite for POST /articles
  describe 'POST /articles' do
    # creating valid test case
    let(:valid_attributes) { { title: 'Understanding Pregnancy', created_by: 'Alice' } }

    context 'when the request is valid' do
      before { post '/articles', params: valid_attributes }

      it 'creates a article' do
        expect(json['title']).to eq('Understanding Pregnancy')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/articles', params: { title: 'Foobar' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  
  # Testing for article updating
  describe 'PUT /articles/:id' do
    let(:valid_attributes) { { title: 'Updated Article Title' } }

    context 'when the record exists' do
      before { put "/articles/#{article_id}", params: valid_attributes }

      it 'updates the article' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Testing for article deletion
  describe 'DELETE /articles/:id' do

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end