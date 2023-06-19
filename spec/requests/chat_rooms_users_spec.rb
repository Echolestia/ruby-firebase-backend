require 'swagger_helper'

describe 'Chat Room Users API' do

  path '/chat_room_users' do
    get 'Retrieves all chat room users' do
      tags 'Chat Room Users'
      produces 'application/json'

      response '200', 'chat room users found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              chat_room_id: { type: :integer },
              user_id: { type: :integer },
            },
            required: ['id', 'chat_room_id', 'user_id']
          }

        run_test!
      end
    end

    post 'Creates a chat room user' do
      tags 'Chat Room Users'
      consumes 'application/json'
      parameter name: :chat_room_user, in: :body, schema: {
        type: :object,
        properties: {
          chat_room_id: { type: :integer },
          user_id: { type: :integer },
        },
        required: ['chat_room_id', 'user_id']
      }

      response '201', 'chat room user created' do
        let(:chat_room_user) { { chat_room_id: 1, user_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:chat_room_user) { { chat_room_id: 1 } }
        run_test!
      end
    end
  end

  path '/chat_room_users/{id}' do
    get 'Retrieves a chat room user' do
      tags 'Chat Room Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'chat room user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            chat_room_id: { type: :integer },
            user_id: { type: :integer },
          },
          required: ['id', 'chat_room_id', 'user_id']

        let(:id) { ChatRoomUser.create(chat_room_user_params).id }
        run_test!
      end

      response '404', 'chat room user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a chat room user' do
      tags 'Chat Room Users'
      parameter name: :id, in: :path, type: :integer
      consumes 'application/json'
      parameter name: :chat_room_user, in: :body, schema: {
        type: :object,
        properties: {
          chat_room_id: { type: :integer },
          user_id: { type: :integer },
        },
        required: ['chat_room_id', 'user_id']
      }

      response '200', 'chat room user updated' do
        let(:chat_room_user) { { user_id: 2 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:chat_room_user) { { user_id: '' } }
        run_test!
      end
    end

    delete 'Deletes a chat room user' do
      tags 'Chat Room Users'
      parameter name: :id, in: :path, type: :integer

      response '204', 'chat room user deleted' do
        let(:id) { ChatRoomUser.create(chat_room_user_params).id }
        run_test!
      end
    end
  end
end
