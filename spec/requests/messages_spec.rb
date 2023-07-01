# spec/requests/messages_spec.rb
require 'swagger_helper'

describe 'Messages API' do

  path '/messages' do
    get 'Retrieves all messages' do
      tags 'Messages'
      produces 'application/json'

      response '200', 'messages found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              sender_id: { type: :integer },
              receiver_id: { type: :integer },
              timestamp: { type: :string, format: 'date-time' },
              sentiment_analysis_score: { type: :number },
              content: { type: :string },
              message_type: { type: :string },
              chat_room_id: { type: :integer },
              read: { type: :boolean }
            },
            required: ['id', 'sender_id', 'receiver_id', 'content', 'message_type']
          }

        run_test!
      end
    end

    post 'Creates a message' do
      tags 'Messages'
      consumes 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          sender_id: { type: :integer },
          receiver_id: { type: :integer },
          timestamp: { type: :string, format: 'date-time' },
          sentiment_analysis_score: { type: :number },
          content: { type: :string },
          message_type: { type: :string },
          chat_room_id: { type: :integer },
          read: { type: :boolean }
        },
        required: ['sender_id', 'receiver_id', 'content', 'message_type']
      }

      response '201', 'message created' do
        let(:message) { { sender_id: 1, receiver_id: 2, content: 'Hello', message_type: 'text' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:message) { { sender_id: 1 } }
        run_test!
      end
    end
  end

  path '/messages/{id}' do
    get 'Retrieves a message' do
      tags 'Messages'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'message found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            sender_id: { type: :integer },
            receiver_id: { type: :integer },
            timestamp: { type: :string, format: 'date-time' },
            sentiment_analysis_score: { type: :number },
            content: { type: :string },
            message_type: { type: :string },
            chat_room_id: { type: :integer },
            read: { type: :boolean }
          },
          required: ['id', 'sender_id', 'receiver_id', 'content', 'message_type']

        let(:id) { Message.create(message_params).id }
        run_test!
      end

      response '404', 'message not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a message' do
      tags 'Messages'
      parameter name: :id, in: :path, type: :integer
      consumes 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          sender_id: { type: :integer },
          receiver_id: { type: :integer },
          timestamp: { type: :string, format: 'date-time' },
          sentiment_analysis_score: { type: :number },
          content: { type: :string },
          message_type: { type: :string },
          chat_room_id: { type: :integer },
          read: { type: :boolean }
        },
        required: ['sender_id', 'receiver_id', 'content', 'message_type']
      }

      response '200', 'message updated' do
        let(:message) { { content: 'Hello, updated content' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:message) { { content: '' } }
        run_test!
      end
    end

    delete 'Deletes a message' do
      tags 'Messages'
      parameter name: :id, in: :path, type: :integer

      response '204', 'message deleted' do
        let(:id) { Message.create(message_params).id }
        run_test!
      end
    end
  end
end
