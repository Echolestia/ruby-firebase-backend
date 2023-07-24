# spec/controllers/articles_controller_spec.rb
require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let!(:article) { Article.find_by(id: 13) }

  before do
    request.headers['Authorization'] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NywiZXhwIjoxNjkwMTc4Njg1fQ.RaI1ml2JGvk9R08yYgj9Hx5RXw3-j4w4_lx0okgLVIA"
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
end
