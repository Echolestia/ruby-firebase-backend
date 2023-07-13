# spec/swagger_helper.rb
require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/api-docs'
  config.swagger_docs = {
    'swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
      },
      securityDefinitions: {
        Bearer: {
          type: :apiKey,
          name: 'Authorization',
          in: :header
        }
      },
      security: [
        {
          Bearer: []
        }
      ],
      paths: {}
    }
  }
end
