require 'swagger_helper'

describe 'Chat Rooms API' do

  path '/chat_rooms' do

    get 'Retrieve chat rooms' do
      tags 'Chat Rooms'
      produces 'application/json'
      parameter name: :ai, in: :query, type: :boolean, description: 'Retrieve only AI chat rooms if set to true'
      parameter name: :user, in: :query, type: :integer, description: 'Retrieve chat rooms related to a specific user'

      response '200', 'chat rooms found' do
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
            last_message: { type: :string },
            unread_messages_count: { type: :integer }
          },
          required: ['id', 'date_created', 'is_ai_chat', 'is_group_chat']
        }

        run_test!
      end
    end

    post 'Create a chat room' do
      tags 'Chat Rooms'
      consumes 'application/json'
      parameter name: :chat_room, in: :body, schema: {
        type: :object,
        properties: {
          user1_id: { type: :integer },
          user2_id: { type: :integer },
          overall_sentiment_analysis_score: { type: :number },
          date_created: { type: :string, format: 'date-time' },
          is_ai_chat: { type: :boolean },
          is_group_chat: { type: :boolean }
        },
        required: ['user1_id']
      }
      parameter name: :ai, in: :query, type: :boolean, description: 'Create an AI chat room'

      response '201', 'Chat room created' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          user1_id: { type: :integer },
          user2_id: { type: :integer },
          overall_sentiment_analysis_score: { type: :number },
          date_created: { type: :string, format: 'date-time' },
          is_ai_chat: { type: :boolean },
          is_group_chat: { type: :boolean }
        }
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end

    path '/chat_rooms/{id}' do

      get 'Retrieve a chat room' do
        tags 'Chat Rooms'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :withMessages, in: :query, type: :boolean, description: 'Include messages in the response if set to true'

        response '200', 'Chat room retrieved' do
          schema type: :object,
          properties: {
            user1_id: { type: :integer },
            user1_first_name: { type: :string },
            user1_second_name: { type: :string },
            user1_picture: { type: :string },
            unread_messages_count_user1: { type: :integer },
            user2_id: { type: :integer },
            user2_first_name: { type: :string },
            user2_second_name: { type: :string },
            user2_picture: { type: :string },
            unread_messages_count_user2: { type: :integer },
            messages: { type: :array, items: { type: :string } }
          }
          run_test!
        end
      end

      put 'Update a chat room' do
        tags 'Chat Rooms'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :chat_room, in: :body, schema: {
          type: :object,
          properties: {
            user1_id: { type: :integer },
            user2_id: { type: :integer },
            overall_sentiment_analysis_score: { type: :number },
            is_ai_chat: { type: :boolean },
            is_group_chat: { type: :boolean }
          }
        }
        parameter name: :ai, in: :query, type: :boolean, description: 'Update to an AI chat room'

        response '200', 'Chat room updated' do
          schema type: :object,
          properties: {
            id: { type: :integer },
            user1_id: { type: :integer },
            user2_id: { type: :integer },
            overall_sentiment_analysis_score: { type: :number },
            is_ai_chat: { type: :boolean },
            is_group_chat: { type: :boolean }
          }
          run_test!
        end

        response '422', 'Invalid request' do
          run_test!
        end
      end

      delete 'Delete a chat room' do
        tags 'Chat Rooms'
        parameter name: :id, in: :path, type: :integer

        response '204', 'Chat room deleted' do
          run_test!
        end
      end
    end
  end
end
