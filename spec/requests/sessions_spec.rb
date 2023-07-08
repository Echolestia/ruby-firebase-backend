# spec/requests/sessions_spec.rb
require 'swagger_helper'

describe 'Sessions API' do

  path '/login' do
    post 'Create a new session' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'Session created' do
        schema type: :object,
        properties: {
          status: { type: :string },
          user_id: { type: :integer }
        },
        required: [ 'status', 'user_id' ]
        
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

  path '/logout' do
    delete 'Destroy a session' do
      tags 'Sessions'
      produces 'application/json'

      response '200', 'Session destroyed' do
        schema type: :object,
        properties: {
          status: { type: :string }
        },
        required: [ 'status' ]
        
        run_test!
      end
    end
  end
end
