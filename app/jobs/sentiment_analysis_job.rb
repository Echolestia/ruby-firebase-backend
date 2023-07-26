class SentimentAnalysisJob < ApplicationJob
    queue_as :default
  
    def perform(message)
        uri = URI.parse("https://sa-new-k6uhsg5paq-as.a.run.app/predict")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        #! disable SSL verification because of issues with the server
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
        request.body = [message.content].to_json
        response = http.request(request)
        sentiment_analysis_score = JSON.parse(response.body)[0]
        message.update(sentiment_analysis_score: sentiment_analysis_score)
    end
  end
  