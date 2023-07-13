# spec/requests/users_spec.rb
require 'swagger_helper'

describe 'Users API' do

  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              user_type: { type: :string },
              profile: { type: :string },
              first_name: { type: :string },
              second_name: { type: :string },
              age: { type: :integer },
              occupation: { type: :string },
              username: { type: :string },
              phone_number: { type: :string },
              gender: { type: :string },
              pregnant: { type: :boolean },
              marital_status: { type: :string },
              pregnancy_week: { type: :integer },
              is_anonymous_login: { type: :boolean },
              survey_result: { type: :string }, 
              email: {type: :string},
              password: {type: :string}
            },
            required: [ 'id', 'user_type', 'profile', 'first_name', 'second_name', 'age', 'occupation', 'username', 'phone_number', 'gender', 'pregnant', 'marital_status', 'pregnancy_week', 'is_anonymous_login', 'survey_result' ]
          }

        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_type: { type: :string },
          profile: { type: :string },
          first_name: { type: :string },
          second_name: { type: :string },
          age: { type: :integer },
          occupation: { type: :string },
          username: { type: :string },
          phone_number: { type: :string },
          gender: { type: :string },
          pregnant: { type: :boolean },
          marital_status: { type: :string },
          pregnancy_week: { type: :integer },
          is_anonymous_login: { type: :boolean },
          survey_result: { type: :string }, 
          email: {type: :string},
          password: {type: :string}
        },
        required: ['first_name', 'second_name', 'username']
      }

      response '201', 'user created' do
        let(:user) { { first_name: 'John', second_name: 'Doe', username: 'johndoe' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { first_name: 'John' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            user_type: { type: :string },
            profile: { type: :string },
            first_name: { type: :string },
            second_name: { type: :string },
            age: { type: :integer },
            occupation: { type: :string },
            username: { type: :string },
            phone_number: { type: :string },
            gender: { type: :string },
            pregnant: { type: :boolean },
            marital_status: { type: :string },
            pregnancy_week: { type: :integer },
            is_anonymous_login: { type: :boolean },
            survey_result: { type: :string }, 
            email: {type: :string},
            password: {type: :string}
          },
          required: [ 'id', 'user_type', 'profile', 'first_name', 'second_name', 'age', 'occupation', 'username', 'phone_number', 'gender', 'pregnant', 'marital_status', 'pregnancy_week', 'is_anonymous_login', 'survey_result' ]

        let(:id) { User.create(user_params).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_type: { type: :string },
          profile: { type: :string },
          first_name: { type: :string },
          second_name: { type: :string },
          age: { type: :integer },
          occupation: { type: :string },
          username: { type: :string },
          phone_number: { type: :string },
          gender: { type: :string },
          pregnant: { type: :boolean },
          marital_status: { type: :string },
          pregnancy_week: { type: :integer },
          is_anonymous_login: { type: :boolean },
          survey_result: { type: :string }, 
          email: {type: :string},
          password: {type: :string}
        }
      }

      response '200', 'user updated' do
        let(:id) { User.create(user_params).id }
        let(:user) { { first_name: 'Jane' } }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { User.create(user_params).id }
        let(:user) { { first_name: '' } }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer

      response '204', 'user deleted' do
        let(:id) { User.create(user_params).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
