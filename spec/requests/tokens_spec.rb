# spec/requests/tokens_spec.rb
require 'swagger_helper'

describe 'Tokens API' do

  path '/login' do
    post 'Create a new token' do
      tags 'Tokens'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'Token created' do
        schema type: :object,
        properties: {
          status: { type: :string },
          token: { type: :string }
        },
        required: [ 'status', 'token' ]
        
        let(:session) { { email: 'test@example.com', password: 'password' } }
        run_test!
      end

      response '422', 'Invalid credentials' do
        schema type: :object,
        properties: {
          error: { type: :string }
        },
        required: [ 'error' ]
        
        let(:session) { { email: 'test@example.com', password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
