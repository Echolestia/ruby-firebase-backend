require 'firebase'

Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_SECRET'])
