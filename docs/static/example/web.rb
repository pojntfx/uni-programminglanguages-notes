require 'sinatra'
require 'sinatra/json'
require 'drb/drb'
require 'json'

require './common'

DRb.start_service

questions = DRbObject.new_with_uri DRUBY_URI

puts "Connected to business on URI #{DRUBY_URI}"

get '/api/questions' do
  for question in questions.questions
    p question
  end

  json questions.questions
end

post '/api/questions' do
  input = JSON.parse request.body.read

  json questions.add_question(input['title'], input['body'])
end

delete '/api/questions/:id' do
  json questions.delete_question(params['id'])
end

get '/questions' do
  @questions = questions.questions

  erb :questions
end

post '/questions' do
  questions.add_question(params['title'], params['body'])

  redirect back
end

post '/questions/:id' do
  questions.delete_question(params['id'])

  redirect back
end

get '/' do
  redirect '/questions'
end
