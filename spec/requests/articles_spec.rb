# spec/requests/articles_spec.rb
require 'swagger_helper'

describe 'Articles API' do

  path '/articles' do
    get 'Retrieves all articles' do
      tags 'Articles'
      produces 'application/json'

      response '200', 'articles found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              published_date: { type: :string, format: 'date-time' },
              created_date: { type: :string, format: 'date-time' },
              title: { type: :string },
              author: { type: :string },
              img_url: { type: :string },
              url: { type: :string },
              user_group: { type: :array, items: { type: :string } }
            },
            required: ['id', 'published_date', 'created_date', 'title', 'author', 'img_url', 'url', 'user_group']
          }

        run_test!
      end
    end
  end

  path '/articles/{id}' do
    get 'Retrieves a article' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'article found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            published_date: { type: :string, format: 'date-time' },
            created_date: { type: :string, format: 'date-time' },
            title: { type: :string },
            author: { type: :string },
            img_url: { type: :string },
            url: { type: :string },
            user_group: { type: :array, items: { type: :string } }
          },
          required: ['id', 'published_date', 'created_date', 'title', 'author', 'img_url', 'url', 'user_group']

        let(:id) { Article.create(article_params).id }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a article' do
      tags 'Articles'
      parameter name: :id, in: :path, type: :integer

      response '204', 'article deleted' do
        let(:id) { Article.create(article_params).id }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/articles' do
    post 'Creates an article' do
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
        required: ['published_date', 'created_date', 'title', 'author', 'img_url', 'url', 'user_group']
      }

      response '201', 'article created' do
        let(:article) { { published_date: '2023-06-01T00:00:00Z', created_date: '2023-06-01T00:00:00Z', title: 'Test', author: 'Test Author', img_url: 'http://test.com', url: 'http://test.com', user_group: ['group1', 'group2'] } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:article) { { title: 'Test' } }
        run_test!
      end
    end
  end

  path '/articles/{id}' do
    put 'Updates an article' do
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

      response '200', 'article updated' do
        let(:id) { Article.create(article_params).id }
        let(:article) { { title: 'Updated Test' } }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Article.create(article_params).id }
        let(:article) { { title: '' } }
        run_test!
      end
    end
  end
  path '/articles/by_user_group/{user_group}' do
    get 'Retrieves articles by user group' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :user_group, in: :path, type: :string
  
      response '200', 'articles found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              published_date: { type: :string, format: 'date-time' },
              created_date: { type: :string, format: 'date-time' },
              title: { type: :string },
              author: { type: :string },
              img_url: { type: :string },
              url: { type: :string },
              user_group: { type: :array, items: { type: :string } }
            },
            required: ['id', 'published_date', 'created_date', 'title', 'author', 'img_url', 'url', 'user_group']
          }
  
        let(:user_group) { 'group1' }
        run_test!
      end
  
      response '404', 'articles not found' do
        let(:user_group) { 'invalid' }
        run_test!
      end
    end
  end
  
end
