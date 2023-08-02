class MessagesController < ApplicationController
    before_action :authenticate
    before_action :set_message, only: [:show, :update, :destroy]
  
    # GET /messages
    def index
      @messages = Message.all
      render json: @messages
    end
  
    # GET /messages/1
    def show
      render json: @message
    end
  
    # POST /messages
    def create
      @message = Message.new(message_params)
      if @message.save
        # construct the JSON data to send
        request_body = [@message.content].to_json

        # create a new URL object
        uri = URI.parse("https://sa-new-k6uhsg5paq-as.a.run.app/predict")
        http = Net::HTTP.new(uri.host, uri.port)
        
        #! disable SSL verification because of issues with the server
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.use_ssl = true

        # initialize a new request object
        request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
        request.body = request_body

        # make the request
        response = http.request(request)

        # update the sentiment analysis score 
        sentiment_analysis_score = JSON.parse(response.body)[0]
        @message.update(sentiment_analysis_score: sentiment_analysis_score)

        # or use Rails logger
        Rails.logger.info "Sentiment Analysis Score: #{sentiment_analysis_score}"
        Rails.logger.info "Message: #{@message.content}"
        
        #? # start a sentiment analysis job, uncomment these 2 lines, but you'll need to run action cable to update the frontend
        #? SentimentAnalysisJob.perform_later(@message)

        # broadcast the new message
        MessageChannel.broadcast_to(@message.chat_room_id, { type: "message", message: @message.as_json })

        render json: @message, status: :created, location: @message
      else
        render json: @message.errors, status: :unprocessable_entity
      end

    end




  
    # PATCH/PUT /messages/1
    def update
      if @message.update(message_params)
        render json: @message
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /messages/1
    def destroy
      @message.destroy
    end
  
    private
    def set_message
      @message = Message.find(params[:id])
    end
    
    def message_params
      params.require(:message).permit(:read, :sender_id, :receiver_id, :timestamp, :sentiment_analysis_score, :content, :message_type, :chat_room_id) if params[:message].present?
    end
    
  end
  