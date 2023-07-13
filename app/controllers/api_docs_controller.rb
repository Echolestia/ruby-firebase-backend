# app/controllers/api_docs_controller.rb

class ApiDocsController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
  
    http_basic_authenticate_with name: "admin", password: "secret"
  
    def index
      render file: Rails.root.join('public', 'api-docs', 'index.html')
    end
  
    def api
      render json: JSON.parse(File.read(Rails.root.join('api-docs', 'swagger.json')))
    end
  end
  