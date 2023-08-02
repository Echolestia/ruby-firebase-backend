# spec/controllers/articles_controller_spec.rb
require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let!(:article) { Article.find_by(id: 14) }

  before do
    request.headers['Authorization'] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkxMDc2Mzk1fQ.G--aqViDpL5rINIb-0QvgcudAYQ5St-QM2frlG-awEg"
  end

  describe "GET #index" do
    it "returns a success response (status 200) and should not be empty" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET #show" do
    it "returns a success response (status 200) when provided with a valid article id" do
      get :show, params: { id: article.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_article_params) {
        {
          published_date: "2023-02-19T00:00:00Z",
          created_date: "2023-06-15T00:00:00Z",
          title: "New Article Title",
          author: "New Author",
          img_url: "https://example.com/new_image.jpg",
          url: "https://example.com/new_article",
          user_group: ["Group 1", "Group 2"]
        }
      }

      it "creates a new Article and returns a created (status 201) response" do
        expect {
          post :create, params: { article: valid_article_params }
        }.to change(Article, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid params" do
      it "does not create a new article and returns an unprocessable entity (status 422) response" do
        post :create, params: { article: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'New Article Title' }
      }

      it "updates the requested article and returns a success response (status 200)" do
        put :update, params: { id: article.to_param, article: new_attributes }
        article.reload
        expect(article.title).to eq('New Article Title')
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid params" do
      it "does not update the article and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: article.to_param, article: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested article and changes the Article count by -1" do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)
    end
  end

  describe "GET #by_user_group" do
    it "returns a success response (status 200) with articles belonging to a specified user group" do
      get :by_user_group, params: { user_group: 'Pregnant Teens' }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  ## PM 4 STUFF!! 
  # Worst case testing
  describe "GET #show" do
    it "returns not found (status 404) when provided with a non-existing article id" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(404)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "returns an unprocessable entity (status 422) response when missing mandatory fields" do
        post :create, params: { article: { title: nil, published_date: nil, created_date: nil, author: nil, url: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with invalid params" do
      it "returns not found (status 404) when updating a non-existing article" do
        put :update, params: { id: 9999, article: { title: 'New Article Title' } }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE #destroy" do
    it "returns not found (status 404) when deleting a non-existing article" do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(404)
    end
  end

  describe "GET #by_user_group" do
    it "returns empty response when there are no articles for a specified user group" do
      get :by_user_group, params: { user_group: 'Non Existent Group' }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to be_empty
    end
  end

  ## BOUNDARY CASE !!
  describe "POST #create" do
    # boundary value testing
    context "with boundary case params" do
      let(:max_length_string) { "a" * 255 }  # Typically a VARCHAR in SQL is 255 characters.

      let(:boundary_article_params) {
        {
          published_date: "2023-02-19T00:00:00Z",
          created_date: "2023-06-15T00:00:00Z",
          title: max_length_string,
          author: max_length_string,
          img_url: "https://example.com/new_image.jpg",
          url: "https://example.com/new_article",
          user_group: ["Group 1", "Group 2"]
        }
      }

      it "creates a new Article with max length title and author and returns a created (status 201) response" do
        expect {
          post :create, params: { article: boundary_article_params }
        }.to change(Article, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    # ROBUST boundary value testing
    context "with out of boundary case params" do
      let(:out_of_bounds_string) { "a" * 256 }  # Length greater than typical VARCHAR in SQL.

      let(:out_of_bounds_article_params) {
        {
          published_date: "2023-02-19T00:00:00Z",
          created_date: "2023-06-15T00:00:00Z",
          title: out_of_bounds_string,
          author: out_of_bounds_string,
          img_url: "https://example.com/new_image.jpg",
          url: "https://example.com/new_article",
          user_group: ["Group 1", "Group 2"]
        }
      }

      it "does not create a new Article with out of bounds length title and author and returns an unprocessable entity (status 422) response" do
        expect {
          post :create, params: { article: out_of_bounds_article_params }
        }.not_to change(Article, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # boundary value testing
  describe "PUT #update" do
    context "with boundary case params" do
      let(:max_length_string) { "a" * 255 }

      it "updates the requested article's title to max length and returns a success response (status 200)" do
        put :update, params: { id: article.to_param, article: { title: max_length_string } }
        article.reload
        expect(article.title).to eq(max_length_string)
        expect(response).to have_http_status(200)
      end
    end

    # robust boundary value testing
    context "with out of boundary case params" do
      let(:out_of_bounds_string) { "a" * 256 }

      it "does not update the article's title to out of bounds length and returns an unprocessable entity (status 422) response" do
        put :update, params: { id: article.to_param, article: { title: out_of_bounds_string } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
