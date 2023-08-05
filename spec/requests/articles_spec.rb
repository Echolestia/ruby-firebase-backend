# spec/requests/articles_spec.rb
require 'swagger_helper'
describe 'Articles API' do

  path '/articles' do

    get 'Retrieve all articles' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :userGroup, in: :query, type: :string, description: 'Retrieve articles related to a specific user group'

      response '200', 'articles found' do
        schema type: :array, items: {
          type: :object,
          properties: {
            published_date: { type: :string, format: 'date-time' },
            created_date: { type: :string, format: 'date-time' },
            title: { type: :string },
            author: { type: :string },
            img_url: { type: :string },
            url: { type: :string },
            user_group: { type: :array, items: { type: :string } }
          },
          required: ['published_date', 'title', 'author']
        }

        run_test!
      end
    end

    post 'Create an article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          published_date: { type: :string, format: 'date-time' },
          created_date: { type: :string, format: 'date-time' },
          title: { type: :string },
          author: { type: :string },
          img_url: { type: :string },
          url: { type: :string },
          user_group: { type: :array, items: { type: :string } }
        },
        required: ['published_date', 'title', 'author']
      }

      response '201', 'Article created' do
        schema type: :object,
        properties: {
          published_date: { type: :string, format: 'date-time' },
          created_date: { type: :string, format: 'date-time' },
          title: { type: :string },
          author: { type: :string },
          img_url: { type: :string },
          url: { type: :string },
          user_group: { type: :array, items: { type: :string } }
        }
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end

  path '/articles/{id}' do

    get 'Retrieve an article' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Article retrieved' do
        schema type: :object,
        properties: {
          published_date: { type: :string, format: 'date-time' },
          created_date: { type: :string, format: 'date-time' },
          title: { type: :string },
          author: { type: :string },
          img_url: { type: :string },
          url: { type: :string },
          user_group: { type: :array, items: { type: :string } }
        }
        run_test!
      end

      response '404', 'Article not found' do
        run_test!
      end
    end

    patch 'Update an article' do
      tags 'Articles'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          published_date: { type: :string, format: 'date-time' },
          created_date: { type: :string, format: 'date-time' },
          title: { type: :string },
          author: { type: :string },
          img_url: { type: :string },
          url: { type: :string },
          user_group: { type: :array, items: { type: :string } }
        }
      }

      response '200', 'Article updated' do
        schema type: :object,
        properties: {
          published_date: { type: :string, format: 'date-time' },
          created_date: { type: :string, format: 'date-time' },
          title: { type: :string },
          author: { type: :string },
          img_url: { type: :string },
          url: { type: :string },
          user_group: { type: :array, items: { type: :string } }
        }
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end

      response '404', 'Article not found' do
        run_test!
      end
    end

    delete 'Delete an article' do
      tags 'Articles'
      parameter name: :id, in: :path, type: :integer

      response '204', 'Article deleted' do
        run_test!
      end

      response '404', 'Article not found' do
        run_test!
      end
    end
  end
end
