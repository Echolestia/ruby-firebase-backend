require 'swagger_helper'

describe 'Chat Rooms API' do

  path '/chat_rooms_for_user/{user_id}' do
    get 'Retrieves all chat rooms for a user' do
      tags 'Chat Rooms'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'chat rooms found for user' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            overall_sentiment_analysis_score: { type: :number },
            date_created: { type: :string, format: 'date-time' },
            is_ai_chat: { type: :boolean },
            is_group_chat: { type: :boolean },
            opponent_id: { type: :integer },
            opponent_first_name: { type: :string },
            opponent_second_name: { type: :string },
            opponent_picture: { type: :string },
          },
          required: ['id', 'date_created', 'is_ai_chat', 'is_group_chat', 'opponent_id', 'opponent_first_name', 'opponent_second_name', 'opponent_picture']
        }

        run_test!
      end
    end
  end

  path '/chat_rooms_with_messages/{id}' do
    get 'Retrieves a chat room with messages' do
      tags 'Chat Rooms'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'chat room found with messages' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            overall_sentiment_analysis_score: { type: :number },
            date_created: { type: :string, format: 'date-time' },
            is_ai_chat: { type: :boolean },
            is_group_chat: { type: :boolean },
            opponent_id: { type: :integer },
            opponent_first_name: { type: :string },
            opponent_second_name: { type: :string },
            opponent_picture: { type: :string },
            messages: { type: :array, 
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  sender_id: { type: :integer },
                  receiver_id: { type: :integer },
                  timestamp: { type: :string, format: 'date-time' },
                  sentiment_analysis_score: { type: :number },
                  content: { type: :string },
                  message_type: { type: :string },
                  chat_room_id: { type: :integer },
                },
                required: ['id', 'sender_id', 'receiver_id', 'content', 'message_type']
              }
            }
          },
          required: ['id', 'date_created', 'is_ai_chat', 'is_group_chat', 'opponent_id', 'opponent_first_name', 'opponent_second_name', 'opponent_picture', 'messages']

        run_test!
      end
    end
  end

  path '/chat_rooms' do
    get 'Retrieves all chat rooms' do
      tags 'Chat Rooms'
      produces 'application/json'

      response '200', 'chat rooms found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              overall_sentiment_analysis_score: { type: :number },
              date_created: { type: :string, format: 'date-time' },
              is_ai_chat: { type: :boolean },
              is_group_chat: { type: :boolean },
            },
            required: ['id', 'date_created', 'is_ai_chat', 'is_group_chat']
          }

        run_test!
      end
    end

    post 'Creates a chat room' do
      tags 'Chat Rooms'
      consumes 'application/json'
      parameter name: :chat_room, in: :body, schema: {
        type: :object,
        properties: {
          overall_sentiment_analysis_score: { type: :number },
          date_created: { type: :string, format: 'date-time' },
          is_ai_chat: { type: :boolean },
          is_group_chat: { type: :boolean },
        },
        required: ['date_created', 'is_ai_chat', 'is_group_chat']
      }

      response '201', 'chat room created' do
        let(:chat_room) { { date_created: '2023-06-20T00:00:00Z', is_ai_chat: false, is_group_chat: true } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:chat_room) { { date_created: '2023-06-20T00:00:00Z' } }
        run_test!
      end
    end
  end

  path '/chat_rooms/{id}' do
    get 'Retrieves a chat room' do
      tags 'Chat Rooms'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'chat room found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            overall_sentiment_analysis_score: { type: :number },
            date_created: { type: :string, format: 'date-time' },
            is_ai_chat: { type: :boolean },
            is_group_chat: { type: :boolean },
          },
          required: ['id', 'date_created', 'is_ai_chat', 'is_group_chat']

        let(:id) { ChatRoom.create(chat_room_params).id }
        run_test!
      end

      response '404', 'chat room not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a chat room' do
      tags 'Chat Rooms'
      parameter name: :id, in: :path, type: :integer
      consumes 'application/json'
      parameter name: :chat_room, in: :body, schema: {
        type: :object,
        properties: {
          overall_sentiment_analysis_score: { type: :number },
          date_created: { type: :string, format: 'date-time' },
          is_ai_chat: { type: :boolean },
          is_group_chat: { type: :boolean },
        },
        required: ['date_created', 'is_ai_chat', 'is_group_chat']
      }

      response '200', 'chat room updated' do
        let(:chat_room) { { is_group_chat: false } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:chat_room) { { date_created: '' } }
        run_test!
      end
    end

    delete 'Deletes a chat room' do
      tags 'Chat Rooms'
      parameter name: :id, in: :path, type: :integer

      response '204', 'chat room deleted' do
        let(:id) { ChatRoom.create(chat_room_params).id }
        run_test!
      end
    end
  end
end
